desc 'add additional questions to the database'
task :add_all_questions => :environment do
	Question.create(short: "Happy", name: "now_how_happy", answer_type: "integer", ordering: 10, ask: "How happy are you right now, 1 to 10?")
  Question.create(short: "Alert", name: "now_how_alert", answer_type: "integer", ordering: 20, ask: "How alert are you right now, 1 to 10?")
  Question.create(short: "Purpose", name: "now_how_purposeful", answer_type: "integer", ordering: 30, ask: "How purposeful do you feel right now, 1 to 10?")
  Question.create(short: "Sleep try", name: "yesterday_sleep_attempted", answer_type: "integer", ordering: 40, ask: "How many minutes of attempted sleep did you have last night?")
  Question.create(short: "Sleep got", name: "yesterday_sleep_effective", answer_type: "integer", ordering: 50, ask: "How many minutes of effective sleep did you have last night?")
  Question.create(short: "Drinks", name: "yesterday_drinks", answer_type: "integer", ordering: 60, ask: "How many drinks did you have last night?")
	Question.create(short: "Food", name: "yesterday_eating", answer_type: "integer", ordering: 70, ask: "How do you feel about how you ate yesterday (1 terribly unhealthy - 10 very healthy)?")
	Question.create(short: "Exercise", name: "yesterday_exercise", answer_type: "integer", ordering: 80, ask: "How do you feel about how much you exercised yesterday (1 none - 10 strenous)?")
	Question.create(short: "Health", name: "yesterday_health", answer_type: "integer", ordering: 90, ask: "How healthy do you feel (1 terribly unhealthy - 10 normal health)?")
  Question.create(short: "Orgasm", name: "yesterday_orgasm", answer_type: "integer", ordering: 100, ask: "Did you orgasm at least once yesterday? (0 no, 1 yes)")
  Question.create(short: "Weight", name: "today_weight", answer_type: "integer", ordering: 110, ask: "To the nearest integer, how much do you weigh today?")
  Question.create(short: "Self-reflection", name: "self_reflection", answer_type: "text", ordering: 120, ask: "What self-reflection do you have at this time?")
end