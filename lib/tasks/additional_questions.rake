desc 'add additional questions to the database'
task :add_additional_questions => :environment do
	Question.create(name: "yesterday_drinks", answer_type: "integer", ordering: 5, ask: "How many drinks did you have last night?")
	Question.create(name: "yesterday_sleep", answer_type: "integer", ordering: 4, ask: "How many minutes of attempted sleep did you have last night?")
	Question.create(name: "yesterday_eating", answer_type: "integer", ordering: 3, ask: "How do you feel about how you ate yesterday (1 terribly unhealthy - 10 very healthy)?")
	Question.create(name: "yesterday_exercise", answer_type: "integer", ordering: 2, ask: "How do you feel about how much you exercised yesterday (1 none - 10 strenous)?")
	Question.create(name: "yesterday_health", answer_type: "integer", ordering: 1, ask: "How healthy do you feel (1 terribly unhealthy - 10 normal health)?")
end

