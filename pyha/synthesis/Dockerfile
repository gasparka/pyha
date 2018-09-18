FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates libglib2.0.0 locales

# clean up
RUN echo "${BUILD_PACKAGES}" | xargs apt-get purge --yes \
 && apt-get autoremove --purge --yes \
&& rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8


ADD quartus/ quartus/
ENV PATH=/quartus/bin/:$PATH
WORKDIR /simulation