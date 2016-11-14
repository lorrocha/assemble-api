# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
    { email: "admin@example.com",
      username: "hoppers13",
      profile_text: "this is my profile"
    },
    { email: "user@email.com",
      username: "zer0c001",
      profile_text: "hello"
    },
    { email: "hello@user.gov",
      username: "hellobrother",
      profile_text: "heyyyy brother"
    },
    { email: "buster@aol.com",
      username: "buster",
      profile_text: "is this where I type"
    },
    { email: "wu@tang.org",
      username: "RZA",
      profile_text: "killa beez"
    },
  ])

teams = Team.create([
    {
      team_name: "Degenderettes",
      privacy: "private"
    },
    {
      team_name: "Haxx0rZ",
      privacy: "private"
    },
    {
      team_name: "buddies",
      privacy: "private"
    },
    {
      team_name: "killa beez",
      privacy: "public"
    },
    {
      team_name: "people I know",
      privacy: "public"
    }
  ])

users.each_with_index { |user, index| user.teams << teams[index] }

teams.first.users << users[4]
teams.last.users << users[0]

alerts = Alert.create([
    {
      alert_text: "halp yer doing me a frighten",
      alert_location: "28.81182, -36.41932"
    },
    {
      alert_text: "someone is following me",
      alert_location: "12.63881, 164.51468"
    },
    {
      alert_text: "come to the coffee shop quick",
      alert_location: "-69.65461, -86.81789"
    },
    {
      alert_text: "he's at my house again, come ASAP",
      alert_location: "17.68777, 80.20643"
    },
    {
      alert_text: "random text",
      alert_location: "-27.44686, 108.54835"
    }
])

teams.each_with_index { |team, index| team.alerts << alerts[index] }
