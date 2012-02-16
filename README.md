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

You must have three environment variables set, `TWILIO_ACCOUNT_SID`, `TWILIO_AUTH_TOKEN` and `TWILIO_FROM`. To do so, add this to your .bash_profile (or some thing that sets up some env vars for you):

    export TWILIO_RECIPIENTS=4151231234
    export TWILIO_FROM=4151231234
    export TWILIO_ACCOUNT_ID=ACxxxxxxx
    export TWILIO_AUTH_TOKEN=xxxxx

If you wish to programically setup those variables, do the following:

    require 'sms'

    SMS.twilio_account_sid = "AC818237237282aadff88d7ef8c"
    SMS.twilio_auth_token = "xxxx"
    SMS.twilio_from = "1231231234"

    sms "hi", "4151231234"

As well, you can have default recipients (via the , so you can leave off the number all the time

    SMS.default_recipients = "4151231234"
    sms "hello there!"


## Binary usage

There is also an `sms` binary. Just call it with the message you wish to send! All arguments past the first one are treated like recipients.

    #> sms "hello there" 4151231234