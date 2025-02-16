# Use the official Ruby image as a base
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /tasklist-backend

# Install Rails
RUN gem install rails

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /tasklist-backend/Gemfile
#COPY Gemfile.lock /tasklist-backend/Gemfile.lock

# Install the Rails dependencies
RUN bundle install

# Copy the rest of the application
COPY . /tasklist-backend

# Set the environment variable for the database URL (set this to the correct DB URL for your environment)
# For production, this can be set manually in the container's environment or through Docker Compose
ENV DATABASE_URL: ${DATABASE_PUBLIC_URL}

# Set environment variables for Rails in production mode
ENV RAILS_ENV=production
ENV RACK_ENV=production

# Expose port 3000 to access the app in a browser
EXPOSE 3000

# Run database setup (creating, migrating, and seeding the database automatically)
#RUN rails db:create db:migrate db:seed

# Command to start the Rails server in production mode
CMD ["rails", "server", "-b", "0.0.0.0"]
