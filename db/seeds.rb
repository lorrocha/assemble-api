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
    { team_name: "Degenderettes" },
    { team_name: "Haxx0rZ" },
    { team_name: "buddies" },
    { team_name: "killa beez" },
    { team_name: "people I know" }
  ])

users.each_with_index { |user, index| user.teams << teams[index] }

teams.first.users << users[4]
teams.last.users << users[0]
