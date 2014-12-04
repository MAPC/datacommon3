FROM rails:onbuild
MAINTAINER Matt Cloyd "mcloyd@mapc.org"

# When building, use `-t "{{user}}/datacommon:{{stage}}"`
# For example, for the dev server, `-t "beechnut/datacommon:dev"`

# Change the first file to .env.local for a local build,
# .env.dev  for the development (group) server
# .env.prep for the staging server
# .env.live for the production server
ADD .env.dev /usr/src/app/.env
RUN RAILS_ENV=production foreman run rake assets:precompile

# Unicorn runs on port 8016
EXPOSE 8016

# Start foreman, using the copied environment variable files
CMD ["foreman", "start", "-e", ".env"]