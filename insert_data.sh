#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do

if [[ $YEAR != "year" ]]
then  
  echo "$($PSQL "insert into teams(name) values('$WINNER'), ('$OPPONENT') ON conflict(name) do nothing;
  insert into games(year, round, winner_goals, opponent_goals, winner_id, opponent_id)
  values($YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, (select team_id from teams where name = '$WINNER'), (select team_id from teams where name = '$OPPONENT'))")"
fi
done