# [NOT MAINTAINED]

#First attempt at dockerizing prediction.io

##This is oh so hacky

Well, first clone the thing
  
    git clone git@github.com:OriPekelman/docker_prediction_io.git
    cd docker_prediction_io

Now you should grab a copy of prediction.io

    wget http://download.prediction.io/PredictionIO-0.6.3.zip

Then it is basically
    sudo docker build -t oripekelman/prediction_io .
    sudo docker run oripekelman/prediction_io

To connect through ssh to the running container (password is 'changeme'):

    ssh root@the_ip_of_docker

See below for a nice helper script for that.

We can basically automate everything except creating the first administrative user. 
After you have run the docker you should ssh to it and run
`/var/lib/predictionio/bin/users`

Weirdly enough we need to fill out a whole form there;

If anything went according to plan you now have a running prediction.io instance accessible on port 8000 of your docker ip


###useful stuff I don't want to forget:
  #commands

  #build container
  sudo docker build -t oripekelman/prediction_io .

  #run container
  CONTAINER_ID=$(sudo docker run oripekelman/prediction_io)

  #bash function help to get docker ip
  docker-ip () {
          sudo docker inspect $1 | grep IPAddress | cut -d '"' -f 4
  }
  #so we can

  ssh root@`docker-ip $CONTAINER_ID`

  #interactive version
  sudo docker run -t -i oripekelman/prediction_io /bin/bash


