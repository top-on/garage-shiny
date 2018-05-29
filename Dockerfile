FROM rocker/shiny

# install some R packages
RUN install2.r --error dplyr lubridate RSQLite ggplot2

COPY ./src /srv/shiny-server/

