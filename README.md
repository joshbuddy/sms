# SMS

Add a Kernel#sms method so you can SMS at any point

## Installation

Add

    gem 'SMS'

to your `Gemfile` or `gem install SMS`

## Usage

    require 'sms'

    sms "Hello", 4151231234
    sms "Hello", "4151231234"
    sms "Hello", ["4151231234", "4157657651"]
    sms ["Hello", "there"], 4151231234

You must have three environment variables set, TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN and TWILIO_FROM. If you wish to programically setup those variables, do the following:

    require 'sms'

    SMS.twilio_account_sid = "AC818237237282aadff88d7ef8c"
    SMS.twilio_auth_token = "xxxx"
    SMS.twilio_from = "1231231234"

    sms "hi", "4151231234"

As well, you can have default recipients, so you can leave off the number all the time

    SMS.default_recipients = "4151231234"
