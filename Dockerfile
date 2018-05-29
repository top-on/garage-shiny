FROM rocker/shiny

# install necessary R packages
RUN install2.r --error dplyr lubridate ggplot2 hms


COPY ./src /srv/shiny-server/

