desc 'add additional questions to the database'
task :add_all_questions => :environment do
	Question.create(name: "now_how_happy", answer_type: "integer", ordering: 0, ask: "How happy are you right now, 1 to 10?")
  Question.create(name: "now_how_alert", answer_type: "integer", ordering: 0, ask: "How alert are you right now, 1 to 10?")
  Question.create(name: "now_how_purposeful", answer_type: "integer", ordering: 0, ask: "How purposeful do you feel right now, 1 to 10?")
  Question.create(name: "yesterday_drinks", answer_type: "integer", ordering: 5, ask: "How many drinks did you have last night?")
	Question.create(name: "yesterday_sleep_attempted", answer_type: "integer", ordering: 4, ask: "How many minutes of attempted sleep did you have last night?")
  Question.create(name: "yesterday_sleep_effective", answer_type: "integer", ordering: 4, ask: "How many minutes of effective sleep did you have last night?")
	Question.create(name: "yesterday_eating", answer_type: "integer", ordering: 3, ask: "How do you feel about how you ate yesterday (1 terribly unhealthy - 10 very healthy)?")
	Question.create(name: "yesterday_exercise", answer_type: "integer", ordering: 2, ask: "How do you feel about how much you exercised yesterday (1 none - 10 strenous)?")
	Question.create(name: "yesterday_health", answer_type: "integer", ordering: 1, ask: "How healthy do you feel (1 terribly unhealthy - 10 normal health)?")
  Question.create(name: "yesterday_orgasm", answer_type: "integer", ordering: 1, ask: "Did you orgasm at least once yesterday? (0 no, 1 yes)")
  Question.create(name: "today_weight", answer_type: "integer", ordering: 1, ask: "To the nearest integer, how much do you weigh today?")
  Question.create(name: "self_reflection", answer_type: "text", ordering: 0, ask: "What self-reflection do you have at this time?")
end