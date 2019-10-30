provider "opsgenie" {
  version = "0.2.3"
  api_url = "api.eu.opsgenie.com"
}

resource "opsgenie_user" "user1" {
  full_name = "Ola Nordmann"
  role = "User"
  username = "ola@nordmann.xyz"
  locale    = "no_NO"
  timezone  = "Europe/Oslo"
}

resource "opsgenie_user" "user2" {
  full_name = "Kari Nordmann"
  role = "User"
  username = "kari@nordmann.xyz"
  locale    = "no_NO"
  timezone  = "Europe/Oslo"
}

resource "opsgenie_team" "team1" {
  name = "Team ONE"

  member {
    id = "${opsgenie_user.user1.id}"
    role = "user"
  }

  member {
    id = "${opsgenie_user.user2.id}"
    role = "user"
  }
}

resource "opsgenie_schedule" "mainschedule" {
  name = "main_schedule"
  owner_team_id = "${opsgenie_team.team1.id}"
}

resource "opsgenie_schedule_rotation" "team1rotation" {
  schedule_id = "${opsgenie_schedule.mainschedule.id}"
  start_date = "2019-10-30T00:00:00Z"
  type = "hourly"
  participant {
    type = "user"
    id = "${opsgenie_user.user1.id}"
  }

  participant {
    type = "user"
    id = "${opsgenie_user.user2.id}"
  }
}

/*

Jeg prøvde å få til escalations, men det er ikke støttet i gratis versjonen.

resource "opsgenie_escalation" "mainscheduleescalation" {
  name = "main_schedule_escalation"
  rules {
    condition = "if-not-acked"
    delay = 5
    notify_type = "users"
    recipient {
      id = "${opsgenie_team.team1.id}"
      type = "team"
    }
  }
}
*/