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

    render json: {
        "count": 100000,
        "filtered": 100000,
        "total": {
          "salary": "330237682",
          "taxes": "267492522.42"
        },
        "data": [
          {
            "dtRowId": 11,
            "name": "Mrs. Elsie Sanford",
            "position": "Electrical and Electronics Drafter",
            "seniority": "Partner",
            "project": "AdminLTE",
            "salary": 1717,
            "taxes": "1390.77",
            "is_active": true,
            "hired_at": "05-03-2015"
          },
          {
            "dtRowId": 12,
            "name": "Kaylin Carter",
            "position": "Legal Secretary",
            "seniority": "Partner",
            "project": "Enso SPA",
            "salary": 1168,
            "taxes": "946.08",
            "is_active": true,
            "hired_at": "24-10-2013"
          },
          {
            "dtRowId": 13,
            "name": "Ephraim Ziemann MD",
            "position": "Health Technologist",
            "seniority": "Senior",
            "project": "Webshop",
            "salary": 3098,
            "taxes": "2509.38",
            "is_active": true,
            "hired_at": "28-12-2014"
          },
          {
            "dtRowId": 14,
            "name": "Troy Nolan DVM",
            "position": "Calibration Technician OR Instrumentation Technician",
            "seniority": "Partner",
            "project": "Webshop",
            "salary": 4714,
            "taxes": "3818.34",
            "is_active": false,
            "hired_at": "07-03-2013"
          },
          {
            "dtRowId": 15,
            "name": "Vicente Parisian",
            "position": "User Experience Manager",
            "seniority": "Senior",
            "project": "Webshop",
            "salary": 1907,
            "taxes": "1544.67",
            "is_active": false,
            "hired_at": "27-02-2017"
          },
          {
            "dtRowId": 16,
            "name": "Carley Pagac",
            "position": "Production Laborer",
            "seniority": "Senior",
            "project": "Enso SPA",
            "salary": 4762,
            "taxes": "3857.22",
            "is_active": false,
            "hired_at": "08-04-2014"
          },
          {
            "dtRowId": 17,
            "name": "Prof. Coralie Heaney",
            "position": "Claims Adjuster",
            "seniority": "Staff",
            "project": "AdminLTE",
            "salary": 2894,
            "taxes": "2344.14",
            "is_active": true,
            "hired_at": "21-03-2016"
          },
          {
            "dtRowId": 18,
            "name": "Beryl Hilpert",
            "position": "Power Generating Plant Operator",
            "seniority": "Associate",
            "project": "AdminLTE",
            "salary": 3430,
            "taxes": "2778.30",
            "is_active": false,
            "hired_at": "09-11-2015"
          },
          {
            "dtRowId": 19,
            "name": "Prof. Kathlyn Gottlieb",
            "position": "Grips",
            "seniority": "Associate",
            "project": "AdminLTE",
            "salary": 3762,
            "taxes": "3047.22",
            "is_active": false,
            "hired_at": "08-06-2016"
          },
          {
            "dtRowId": 20,
            "name": "Mr. Martin Bechtelar PhD",
            "position": "Gaming Dealer",
            "seniority": "Assistant",
            "project": "Webshop",
            "salary": 1872,
            "taxes": "1516.32",
            "is_active": true,
            "hired_at": "31-10-2017"
          }
        ],
        "fullRecordInfo": true,
        "filters": true
      }
  end

  def init_users
    render json: {
                  "template": {
                    "crtNo": true,
                    "selectable": true,
                    "buttons": {
                      "global": [
                        {
                          "type": "global",
                          "icon": "file-excel",
                          "class": "is-outlined",
                          "event": "excel",
                          "label": "Excel"
                        },
                        {
                          "type": "global",
                          "icon": "plus",
                          "class": "is-outlined",
                          "event": "create",
                          "label": "Create"
                        }
                      ],
                      "row": [
                        {
                          "type": "row",
                          "icon": "pencil-alt",
                          "class": "is-naked",
                          "event": "edit"
                        },
                        {
                          "type": "row",
                          "icon": "trash-alt",
                          "class": "is-naked",
                          "event": "destroy",
                          "confirmation": true,
                          "message": "This is your custom confirmation. Are you sure?"
                        }
                      ]
                    },
                    "columns": [
                      {
                        "label": "Name",
                        "name": "name",
                        "data": "examples.name",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Position",
                        "name": "position",
                        "data": "examples.position",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": false,
                          "date": false,
                          "icon": false,
                          "clickable": true,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Seniority",
                        "name": "seniority",
                        "data": "examples.seniority",
                        "enum": "LaravelEnso\\Examples\\app\\Enums\\SeniorityEnum",
                        "meta": {
                          "searchable": false,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Project",
                        "name": "project",
                        "data": "examples.project",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": true,
                          "rogue": false,
                          "editable": false,
                          "total": false,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Salary",
                        "name": "salary",
                        "data": "examples.salary",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": true,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        },
                        "money": {}
                      },
                      {
                        "label": "Taxes",
                        "name": "taxes",
                        "data": "examples.taxes",
                        "meta": {
                          "searchable": true,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": true,
                          "date": false,
                          "icon": false,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": true,
                          "hidden": false,
                          "sort": "null"
                        },
                        "money": {}
                      },
                      {
                        "label": "Active",
                        "name": "is_active",
                        "data": "examples.is_active",
                        "meta": {
                          "searchable": false,
                          "sortable": true,
                          "translation": false,
                          "boolean": true,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": false,
                          "date": false,
                          "icon": true,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
                          "nullLast": false,
                          "visible": false,
                          "hidden": true,
                          "sort": "null"
                        }
                      },
                      {
                        "label": "Hired Since",
                        "name": "hired_at",
                        "data": "examples.hired_at",
                        "meta": {
                          "searchable": false,
                          "sortable": true,
                          "translation": false,
                          "boolean": false,
                          "slot": false,
                          "rogue": false,
                          "editable": false,
                          "total": false,
                          "date": true,
                          "icon": false,
                          "clickable": false,
                          "customTotal": false,
                          "notExportable": false,
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
                    "enum": true,
                    "money": true,
                    "date": true,
                    "searchable": true,
                    "sort": false,
                    "labels": {
                      "crtNo": "#",
                      "actions": "Actions"
                    },
                    "pathSegment": "table",
                    "actions": true,
                    "align": "has-text-centered",
                    "style": "is-hoverable",
                    "aligns": {
                      "center": "has-text-centered",
                      "left": "has-text-left",
                      "right": "has-text-right"
                    },
                    "styles": {
                      "compact": "is-narrow",
                      "hover": "is-hoverable",
                      "striped": "is-striped",
                      "bordered": "is-bordered"
                    },
                    "highlight": "has-background-info"
                  }
                }
  end
end
