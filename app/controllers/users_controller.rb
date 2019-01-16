class UsersController < ApplicationController
  def index
    case_value = "(CASE WHEN (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) >= 0 THEN (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) ELSE 0 end)"
    column,order = params["sort"].split("|")

    sorting1 = ""
    sorting2 = ""

    first_sort = ["payment_method", "username", "name", "email", "api_id", "api_key", "cameras_owned", "camera_shares", "snapmail_count", "country", "created_at", "last_login_at", "required_licence", "referral_url"]
    second_sort = ["total_cameras", "valid_licence", "required_licence", "def"]
    if first_sort.include? column
      sorting1 = sorting(column, order)
    end
    if second_sort.include? column
      sorting2 = sorting(column, order)
    end

    condition = "where 1=1"
    if params[:username].present?
      condition += " and lower(u.username) like lower('%#{params[:username]}%')"
    end
    if params[:email].present?
      condition += " and lower(u.email) like lower('%#{params[:email]}%')"
    end
    if params[:fullname].present?
      condition += " and lower(u.firstname || ' ' || u.lastname) like lower('%#{params[:fullname]}%')"
    end
    if params[:payment_method].present?
      condition += " and u.payment_method=#{params[:payment_method].to_i}"
    end
    if params[:created_at_date].present?
      condition += " and u.created_at < date_trunc('month', CURRENT_DATE) - INTERVAL '#{params[:created_at_date].to_i / 12.0} year'"
    end
    if params[:last_login_at_date].present?
      condition += " and u.last_login_at < date_trunc('month', CURRENT_DATE) - INTERVAL '#{params[:last_login_at_date].to_i / 12.0} year'"
    end
    if params[:last_login_at_boolean].present? && params[:last_login_at_boolean] == "true"
      condition += " and u.last_login_at is not null"
    end
    if params[:last_login_at_boolean].present? && params[:last_login_at_boolean] == "false"
      condition += " and u.last_login_at is null"
    end
    if params[:last_login_at_boolean].present? && params[:last_login_at_boolean] == "whatever"
      condition += ""
    end

    if params[:total_cameras].present?
      condition2 = "where (cameras_owned + camera_shares) = #{params[:total_cameras]}"
    elsif params[:cameras_owned].present? && params[:camera_shares].present? && params[:include_erc].present? && params[:include_erc] == "true"
      condition2 = "where cameras_owned < #{params[:cameras_owned]} and camera_shares < #{params[:camera_shares]} and share_id > 0"
    elsif params[:cameras_owned].present? && params[:camera_shares].present? && params[:include_erc].present? && params[:include_erc] == "false"
      condition2 = "where cameras_owned < #{params[:cameras_owned]} and camera_shares < #{params[:camera_shares]} and share_id = 0"
    elsif params[:camera_shares].present? && params[:include_erc].present? && params[:include_erc] == "false"
      condition2 = "where camera_shares < #{params[:camera_shares]} and share_id = 0"
    elsif params[:camera_shares].present? && params[:include_erc].present? && params[:include_erc] == "true"
      condition2 = "where camera_shares < #{params[:camera_shares]} and share_id > 0"
    elsif params[:cameras_owned].present? && params[:include_erc].present? && params[:include_erc] == "false"
      condition2 = "where cameras_owned < #{params[:cameras_owned]} and share_id = 0"
    elsif params[:cameras_owned].present? && params[:include_erc].present? && params[:include_erc] == "true"
      condition2 = "where cameras_owned < #{params[:cameras_owned]} and share_id > 0"
    elsif params[:camera_shares].present? && params[:cameras_owned].present?
      condition2 = "where cameras_owned < #{params[:cameras_owned]} and camera_shares < #{params[:camera_shares]}"
    elsif params[:camera_shares].present?
      condition2 = "where camera_shares < #{params[:camera_shares]}"
    elsif params[:cameras_owned].present?
      condition2 = "where cameras_owned < #{params[:cameras_owned]}"
    elsif params[:licREQ1].present? && params[:licREQ2].present?
      condition2 = "where required_licence > #{params[:licREQ1]} and required_licence < #{params[:licREQ2]}"
    elsif params[:licVALID1].present? && params[:licVALID2].present?
      condition2 = "where valid_licence > #{params[:licVALID1]} and valid_licence < #{params[:licVALID2]}"
    elsif params[:licDEF1].present? && params[:licDEF2].present?
      condition2 = "where (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) > #{params[:licDEF1]} and (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) < #{params[:licDEF2]}"
    elsif params[:licDEF1].present?
      condition2 = "where (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) > #{params[:licDEF1]}"
    elsif params[:licDEF2].present?
      condition2 = "where (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) < #{params[:licDEF2]}"
    elsif params[:licVALID1].present?
      condition2 = "where valid_licence > #{params[:licVALID1]}"
    elsif params[:licVALID2].present?
      condition2 = "where valid_licence < #{params[:licVALID2]}"
    elsif params[:licREQ1].present?
      condition2 = "where required_licence > #{params[:licREQ1]}"
    elsif params[:licREQ2].present?
      condition2 = "where required_licence < #{params[:licREQ2]}"
    elsif params[:include_erc].present? && params[:include_erc] == "false"
      condition2 = "where share_id = 0"
    elsif params[:include_erc].present? && params[:include_erc] == "true"
      condition2 = "where share_id > 0"
    elsif params[:include_erc].present? && params[:include_erc] == "whatever"
      condition2 = ""
    else
      condition2 = ""
    end

    users = User.connection.select_all("select *, #{case_value} def, (cameras_owned + camera_shares) total_cameras from (
                 select *, (select count(cr.id) from cloud_recordings cr left join cameras c on c.owner_id=u.id where c.id=cr.camera_id and cr.status <>'off' and cr.storage_duration <> 1) required_licence,
                 (select SUM(l.total_cameras) from licences l left join users uu on l.user_id=uu.id where uu.id=u.id and cancel_licence=false) valid_licence,
                 (select count(*) from cameras cc left join users uuu on cc.owner_id=uuu.id where uuu.id=u.id) cameras_owned,
                 (select count(*) from camera_shares cs left join users uuuu on cs.user_id=uuuu.id where uuuu.id = u.id) camera_shares,
                 (select count(*) from snapmails sm left join users suser on sm.user_id=suser.id where suser.id = u.id) snapmail_count,
                 (select name from countries ct left join users uuuuu on ct.id=uuuuu.country_id where uuuuu.id=u.id) country,
                 (select count(cs1.id) from camera_shares cs1 where cs1.user_id=u.id and cs1.camera_id = 279) share_id
                 from users u #{condition} #{sorting1}
                ) t #{condition2} #{sorting2}")
    total_records = users.count
    display_length = params["per_page"].to_i
    display_length = display_length < 0 ? total_records : display_length
    display_start = params["page"].to_i <= 1 ? 0 : (params["page"].to_i - 1) * display_length + 1

    index_end = ((params["page"].to_i - 1) * display_length) + display_length
    index_end = index_end > total_records ? total_records - 1 : index_end
    last_page = (total_records / display_length.to_f).round
    records = {
      data: [],
      total: total_records,
      per_page: display_length,
      from: display_start,
      to: index_end,
      current_page: params["page"],
      last_page: last_page,
      next_page_url: params["page"].to_i == last_page ? "" : "/v1/users?sort=#{params["sort"]}&per_page=#{display_length}&page=#{params["page"].to_i + 1}",
      prev_page_url: params["page"].to_i < 1 ? "" : "/v1/users?sort=#{params["sort"]}&per_page=#{display_length}&page=#{params["page"].to_i - 1}"
    }
    (display_start..index_end).each do |index|
      records[:data][records[:data].count] = {
        username: users[index]["username"],
        name: users[index]["firstname"] + " " + users[index]["lastname"],
        email: users[index]["email"],
        api_id: users[index]["api_id"],
        api_key: users[index]["api_key"],
        cameras_owned: users[index]["cameras_owned"],
        camera_shares: users[index]["camera_shares"],
        total_cameras: users[index]["total_cameras"],
        country: users[index]["country"],
        created_at: users[index]["created_at"] ? DateTime.parse(users[index]["created_at"]).strftime("%A, %d %b %Y %l:%M %p") : "",
        confirmed_at: users[index]["confirmed_at"] ? DateTime.parse(users[index]["confirmed_at"]).strftime("%A, %d %b %Y %l:%M %p") : "",
        last_login_at: users[index]["last_login_at"] ? DateTime.parse(users[index]["last_login_at"]).strftime("%A, %d %b %Y %l:%M %p") : "",
        required_licence: users[index]["required_licence"],
        valid_licence: users[index]["valid_licence"],
        def: users[index]["def"],
        payment_method: users[index]["payment_method"],
        id: users[index]["id"],
        referral_url: users[index]["referral_url"],
        snapmail_count: users[index]["snapmail_count"]
      }
    end
    @pageload = false
    render json: records
  end

  private

  def sorting(col, order)
    case col
      when "payment_method"
        "order by payment_method #{order}"
      when "username"
        "order by u.username #{order}"
      when "name"
        "order by u.firstname #{order}"
      when "email"
        "order by u.email #{order}"
      when "api_id"
        "order by u.api_id #{order}"
      when "api_key"
        "order by u.api_key #{order}"
      when "cameras_owned"
        "order by cameras_owned #{order}"
      when "camera_shares"
        "order by camera_shares #{order}"
      when "total_cameras"
        "order by total_cameras #{order}"
      when "snapmail_count"
        "order by snapmail_count #{order}"
      when "country"
        "order by country #{order}"
      when "created_at"
        "order by created_at #{order}"
      when "last_login_at"
        "order by last_login_at #{order}"
      when "required_licence"
        "order by required_licence #{order}"
      when "valid_licence"
        "order by valid_licence #{order}"
      when "def"
        "order by def #{order}"
      when "referral_url"
        "order by referral_url #{order}"
      when "id"
        "order by u.id desc"
      else
        "order by id #{order}"
    end
  end
end
