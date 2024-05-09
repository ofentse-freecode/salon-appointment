#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=salon -t -c"


echo -e "\n~~~~~ Salon Shop ~~~~~\n"
 echo -e "How may I help you today?\n"

MAIN_MENU(){

AVAILABLE_SERVICES=$($PSQL  "SELECT service_id, name FROM services ORDER BY service_id")
echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
    do
      echo "$SERVICE_ID) $NAME"
    done
  read SERVICE_ID_SELECTED


     if [[ ! $SERVICE_ID_SELECTED =~ ^[0-3]+$ ]]
     then
    echo "I could not find that service. What would you like today?"
    MAIN_MENU
     else
  CUSTOMER
fi
}

#SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
CUSTOMER() {
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  echo "What's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
 if [[ -z $CUSTOMER_NAME ]]
        then
        # get new customer name
        echo -e "\nWhat's your name?"
        read CUSTOMER_NAME
        # insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
        else
        echo "What time would you like your $SERVICE_SELECTED, $CUSTOMER_NAME?"
          
        fi
        echo "What time would you like your $SERVICE_SELECTED, $CUSTOMER_NAME?"
          read SERVICE_TIME
          #INSERT_APOINTMENT=$($PSQL "INSERT INTO")
          CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE name = '$CUSTOMER_NAME'")
          INSERT_APOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
          #SUCCESS
          echo "I have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME."
          #SUCCESS
        
}


MAIN_MENU
