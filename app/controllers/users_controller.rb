class UsersController < ApplicationController

  def load_users
    users = User.connection.select_all(
                "select *, (CASE WHEN (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) >= 0 THEN (required_licence - (CASE WHEN valid_licence >=0 THEN valid_licence ELSE 0 END)) ELSE 0 end) def, (cameras_owned + camera_shares) total_cameras from (
                 select *, (select count(cr.id) from cloud_recordings cr left join cameras c on c.owner_id=u.id where c.id=cr.camera_id and cr.status <>'off' and cr.storage_duration <> 1) required_licence,
                 (select SUM(l.total_cameras) from licences l left join users uu on l.user_id=uu.id where uu.id=u.id and cancel_licence=false) valid_licence,
                 (select count(*) from cameras cc left join users uuu on cc.owner_id=uuu.id where uuu.id=u.id) cameras_owned,
                 (select count(*) from camera_shares cs left join users uuuu on cs.user_id=uuuu.id where uuuu.id = u.id) camera_shares,
                 (select count(*) from snapmails sm left join users suser on sm.user_id=suser.id where suser.id = u.id) snapmail_count,
                 (select name from countries ct left join users uuuuu on ct.id=uuuuu.country_id where uuuuu.id=u.id) country,
                 (select count(cs1.id) from camera_shares cs1 where cs1.user_id=u.id and cs1.camera_id = 279) share_id
                 from users u where 1=1 order by created_at desc
                ) t"
              )
    total_records = users.count
    meta = JSON.parse(params["meta"])
    display_length = meta["length"].to_i
    display_length = display_length < 0 ? total_records : display_length
    display_start = meta["start"].to_i
    table_draw = params[:draw].to_i

    index_end = display_start + display_length
    index_end = index_end > total_records ? total_records - 1 : index_end
    records = { data: [], draw: table_draw, count: total_records, filtered: total_records, fullRecordInfo: true, filters: true }
    (display_start..index_end).each do |index|
      records[:data][records[:data].count] = {
        "dtRowId": users[index]["id"],
        "username": users[index]["username"],
        "name": users[index]["firstname"] + " " + users[index]["lastname"],
        "email": users[index]["email"],
        "api_id": users[index]["api_id"],
        "api_key": users[index]["api_key"],
        "cameras_owned": users[index]["cameras_owned"],
        "camera_shares": users[index]["camera_shares"],
        "total_cameras": users[index]["total_cameras"],
        "country": users[index]["country"],
        "created_at": users[index]["created_at"] ? DateTime.parse(users[index]["created_at"]).strftime("%A, %d %b %Y %l:%M %p") : "",
        "confirmed_at": users[index]["confirmed_at"] ? DateTime.parse(users[index]["confirmed_at"]).strftime("%A, %d %b %Y %l:%M %p") : "",
        "last_login_at": users[index]["last_login_at"] ? DateTime.parse(users[index]["last_login_at"]).strftime("%A, %d %b %Y %l:%M %p") : "",
        "required_licence": users[index]["required_licence"],
        "valid_licence": users[index]["valid_licence"],
        "def": users[index]["def"],
        "payment_method": users[index]["payment_method"],
        "referral_url": users[index]["referral_url"],
        "snapmail_count": users[index]["snapmail_count"]
      }
    end
    @pageload = false
    render json: records
  end

  def init_users
    render json: {
                  "template": {
                    "crtNo": false,
                    "selectable": true,
                    "buttons": {
                      "global": [
                        {
                          "type": "global",
                          "icon": "plus",
                          "class": "is-outlined",
                          "event": "create",
                          "label": "Create"
                        }
                      ],
                      "row": [
                      ]
                    },
                    "columns": [
                      {
                        "label": "Name",
                        "name": "name",
                        "data": "name",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Username",
                        "name": "username",
                        "data": "username",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Email",
                        "name": "email",
                        "data": "email",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "API Id",
                        "name": "api_id",
                        "data": "api_id",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "API Key",
                        "name": "api_key",
                        "data": "api_key",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Camera Owned",
                        "name": "cameras_owned",
                        "data": "cameras_owned",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Camera Shared",
                        "name": "camera_shares",
                        "data": "camera_shares",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Cameras Total",
                        "name": "total_cameras",
                        "data": "total_cameras",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Created At",
                        "name": "created_at",
                        "data": "created_at",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Confirmed At",
                        "name": "confirmed_at",
                        "data": "confirmed_at",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Country",
                        "name": "country",
                        "data": "country",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Last Login At",
                        "name": "last_login_at",
                        "data": "last_login_at",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "notExportable": true,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      }
                    ],
                    "readPath": "/load_users",
                    "lengthMenu": [
                      10,
                      15,
                      20,
                      25,
                      30
                    ],
                    "debounce": 100,
                    "method": "GET",
                    "total": true,
                    "date": true,
                    "searchable": true,
                    "sort": false,
                    "labels": {
                    },
                    "pathSegment": "table",
                    "actions": false,
                    "align": "has-text-centered",
                    "style": "is-bordered",
                    "aligns": {
                      "center": "has-text-centered",
                      "left": "has-text-left",
                      "right": "has-text-right"
                    },
                    "highlight": "has-background-info"
                  }
                }
  end
end
