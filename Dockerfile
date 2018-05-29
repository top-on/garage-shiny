FROM rocker/shiny

# install necessary R packages
RUN install2.r --error dplyr lubridate RSQLite ggplot2

COPY ./src /srv/shiny-server/

