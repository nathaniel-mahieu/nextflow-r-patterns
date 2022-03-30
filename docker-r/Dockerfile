FROM rocker/r-ver:4.1.0

RUN apt-get update
RUN apt-get install -y git

# This is the only dependency lacking version control: remotes.  Could renv::imbue then install?
RUN R -e " \
  install.packages('remotes'); \
  remotes::install_version('renv', version = '0.15.2', repos = 'http://cran.us.r-project.org') \
  "

# Install dependencies
RUN apt-get install -y libnetcdf-*

# Using renv we snapshot dependencies for each nextflow script with renv::snapshot().  The renv.lock files for each nextflow script are dumped into this dir.  When a nextflow script is run renv::restore(lockfile = 'renv.lock...n') is called. This pulls from the cache we build in this step (and hopefully is pretty fast, will benchmark later).
# This step is separate so docker can cache it
ADD ./renv-lockfiles/base-lockfile.lock /home/analysis/renv-lockfiles/base-lockfile.lock
RUN R -e " \
    renv::restore(lockfile = '/home/analysis/renv-lockfiles/base-lockfile.lock'); \
    "
# Grab and cache all versioned dependencies with renv
ADD ./renv-lockfiles /home/analysis/renv-lockfiles
RUN R -e " \
    lapply(list.files('/home/analysis/renv-lockfiles/', full.names=T), function(x) { renv::restore(lockfile = x);  }) \
    "