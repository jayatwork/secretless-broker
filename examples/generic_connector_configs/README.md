# Generic HTTP Connector Example Configurations

## Table of Contents
* [Sample Configurations](#sample-configurations)
  * [Datadog API](#datadog-api)
  * [Docker Registry API](#docker-registry-api)
  * [Dropbox API](#dropbox-api)
  * [Elasticsearch API](#elasticsearch-api)
  * [GitHub API](#github-api)
  * [Mailchimp API](#mailchimp-api)
  * [OAuth 2.0 API](#oauth-20-api)
  * [SendGrid Web API](#sendgrid-web-api)
  * [Slack Web API](#slack-web-api)
  * [Splunk API](#splunk-api)
  * [Stripe API](#stripe-api)
  * [Tableau API](#tableau-api)
  * [Twitter API](#twitter-api)
* [Contributing](#contributing)

## Introduction
The
[generic HTTP connector](../../internal/plugin/connectors/http/generic/README.md)
enables using Secretless with a wide array of HTTP-based services _without
having to write new Secretless connectors_. Instead, you can modify your
Secretless configuration to specify the header structure the HTTP service
requires to authenticate.

## Sample Configurations
This section contains a list of generic HTTP configurations that have been
built already. Each configuration contains an example of how to run the API
locally.

If your target uses self-signed certs you will need to follow the
[documented instructions](https://docs.secretless.io/Latest/en/Content/References/connectors/scl_handlers-https.htm#Manageservercertificates) for adding the
target’s CA to Secretless’ trusted certificate pool.

> Note: The following examples use the [Keychain provider](https://docs.cyberark.com/Product-Doc/OnlineHelp/AAM-DAP/11.3/en/Content/References/providers/scl_keychain.htm?TocPath=Fundamentals%7CSecretless%20Pattern%7CSecret%20Providers%7C_____5).
> Replace the service prefix `service#` with an appropriate service
> or use a different provider as needed.

> **Protip:** Your target should be either `http://api-target.com` or
`api-target.com`. A URL that starts with https will not work.
___

### Datadog API
This example can be used to interact with
[Datadog API](https://docs.datadoghq.com/api/v2/).

The configuration file for the Datadog API can be found at
[datadog_secretless.yml](./datadog_secretless.yml).

This configuration uses [v2](https://docs.datadoghq.com/api/v2/)
of the DataDog API.

#### How to use this connector

* Edit the supplied configuration to get your Datadog
[API Key](https://docs.datadoghq.com/account_management/api-app-keys/)
or/and
[Application Key](https://docs.datadoghq.com/account_management/api-app-keys/)
* Run Secretless with the supplied configuration(s)
* Query the Datadog API using

  ```
  http_proxy=localhost:8041 curl api.datadoghq.com/{request}
  ```

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Set up a [Datadog Account](https://app.datadoghq.com/) and get an
     [API Key](https://docs.datadoghq.com/account_management/api-app-keys/)
  1. Get a DataDog
     [Application key](<https://></https://>docs.datadoghq.com/account_management/api-app-keys/)
  1. Store the token from your request in your local credential manager so
  that it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
     ./dist/darwin/amd64/secretless-broker \
     -f examples/generic_connector_configs/datadog_secretless.yml
     ```
  1. Query the API using
  `http_proxy=localhost:8041 curl api.datadoghq.com/api/v1/user`

</details>

___

### Docker Registry API

This example can be used to interact with
[Docker's V2 Registry API](https://docs.docker.com/registry/spec/api/#overview).

The configuration file for the Docker Registry API can be found at
[docker_registry_secretless.yml](./docker_registry_secretless.yml).

> This configuration uses v2 of the Docker Registry API.

#### How to use this connector

* Edit the supplied configuration to get your Docker Registry
[Token](https://docs.docker.com/registry/spec/auth/jwt/)
* Run Secretless with the supplied configuration(s)
* Query the Docker Registry API using

  ```
  http_proxy=localhost:8021 curl <Registry Endpoint URL>/{Request}
  ```

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Set up a [local Registry](https://docs.docker.com/registry/deploying/)
  or use one from [Dockerhub](https://hub.docker.com)
  1. Make a request to the Registry API to get the
  [OAuth2 Token](https://docs.docker.com/registry/spec/auth/oauth/).
  1. Store the token from your request in your local credential manager so
  that it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
     ./dist/darwin/amd64/secretless-broker \
     -f examples/generic_connector_configs/docker_registry_secretless.yml
     ```
  1. List all images from your test Registry using
  `http_proxy=localhost:8021 curl {Registry Endpoint}/v2/repositories/{USERNAME}/?page_size=10000`
  1. If you can see the private repos in your repo, you're all set!

</details>

___

### Dropbox API
This example can be used to interact with
[Dropbox's API](https://www.dropbox.com/developers/documentation/http/overview).

The configuration file for the Dropbox API can be found at
[dropbox_secretless.yml](./dropbox_secretless.yml).

> This configuration uses v2 of the Dropbox API.

#### How to use this connector

* Edit the supplied configuration to get your
[Dropbox API token](https://www.dropbox.com/developers/apps) or
[App key and App Secret](https://www.dropbox.com/developers/apps)
* Run Secretless with the supplied configuration
* Query the Dropbox API using
`http_proxy=localhost:8081 curl {Dropbox Route}/{Request}`

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally</b></summary>

  1. Get an OAuth token from the settings page of a
     [Dropbox application](https://www.dropbox.com/developers/apps)
  1. Store the token from your request in your local credential manager so
      that it may be retrieved in your `secretless.yml`
  1. Build and run Secretless locally
     ```
     ./bin/build_darwin
     ./dist/darwin/amd64/secretless-broker \
          -f examples/generic_connector_configs/dropbox_secretless.yml
     ```
  1. On another terminal window, make a request to Dropbox using Secretless
     ```
     http_proxy=localhost:8081 curl -X POST api.dropboxapi.com/2/team/get_info
     ```
</details>

___

### Elasticsearch API
This example can be used to interact with
[Elasticsearch's API](https://www.elastic.co/guide/en/elasticsearch/reference/current).

The configuration file for the Elasticsearch API can be found at
[elasticsearch_secretless.yml](./elasticsearch_secretless.yml).

> This configuration uses v7.8 of the Elasticsearch API.

#### How to use this connector

* Edit the supplied configuration to get your Elasticsearch
[API Key](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api-create-api-key.html)
or
[OAuth token](https://www.elastic.co/guide/en/elasticsearch/reference/current/security-api-get-token.html)
* Run Secretless with the supplied configuration(s)
* Query the Elasticsearch API using

  ```
  http_proxy=localhost:9020 curl {Elasticsearch Endpoint URL}/{Request}
  ```

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Create an account at
  [Elasticsearch's website](https://cloud.elastic.co/login)
  1. Create a
  [deployment](https://www.elastic.co/guide/en/cloud-enterprise/current/ece-restful-api-examples-create-deployment.html)
  1. Make a request to Elasticsearch's API to get the
  [OAuth2 Token](https://www.elastic.co/guide/en/elasticsearch/reference/master/security-api-get-token.html).
  The request should be made to your deployment Elasticsearch endpoint.
  1. Run Secretless locally
     ```
     ./dist/darwin/amd64/secretless-broker \
     -f examples/generic_connector_configs/elasticsearch.yml
     ```
  1. Query the Elasticsearch API using
     ```
     http_proxy=localhost:9020 curl <Elasticsearch Endpoint URL>/{Request}
     ```

</details>

___

### GitHub API
This example can be used to interact with
[GitHub's API](https://developer.github.com/v3/).

The configuration file for the GitHub API can be found at
[github_secretless.yml](./github_secretless.yml).

> This configuration uses v3 of the Github API.

#### How to use this connector
* Edit the supplied configuration to get your
[GitHub OAuth token](https://developer.github.com/v3/#oauth2-token-sent-in-a-header)
from the correct provider/path.
* Run Secretless with the supplied configuration
* Query the GitHub API using

  ```
  http_proxy=localhost:8081 curl api.github.com/{request}
  ```

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Get an OAuth token from the Developer Settings page of a user's
  GitHub account
  1. Store the token from your request in your local credential manager so
  that it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
        ./dist/darwin/amd64/secretless-broker \
        -f examples/generic_connector_configs/github_secretless.yml
     ```
  1. On another terminal window, make a request to GitHub using Secretless
     ```
        http_proxy=localhost:8081 curl -X GET api.github.com/users/username
     ```

</details>

___

### Mailchimp API
This example can be used to interact with
[Mailchimp's API](https://mailchimp.com/developer/guides/get-started-with-mailchimp-api-3/).

The configuration file for the Mailchimp API can be found at
[mailchimp_secretless.yml](./mailchimp_secretless.yml).

> This configuration uses v3 of the Mailchimp API.

#### How to use this connector

* Edit the supplied configuration to get your Mailchimp OAuth
  [Access Token](https://mailchimp.com/developer/guides/how-to-use-oauth2/)
  OAuth2 or Mailchimp
  [API Token/Username](https://mailchimp.com/help/about-api-keys/)
  Basic Authentication from the correct provider/path.
* Run Secretless with the supplied configuration
* Query the Mailchimp API using:

  ```
  http_proxy=localhost:{Service IP} curl {dc}.api.mailchimp.com/3.0/{request}
  ```

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  **Basic Authentication**

  1. Get an API token from Profile > Extras > API Keys > "Create A Key"
  1. Store your username and the token from your request in your local
     credential manager so that it may be retrieved in your
     `mailchimp_secretless.yml`
  1. Run Secretless locally
     ```
       ./dist/darwin/amd64/secretless-broker \
       -f examples/generic_connector_configs/mailchimp_secretless.yml
     ```
  1. On another terminal window, make a request to Mailchimp using Secretless
     ```
       http_proxy=localhost:8010 curl -X GET {dc}.api.mailchimp.com/3.0/
     ```

  **OAuth2**

  1. Get an Access Token by following the
  [provided workflow](https://mailchimp.com/developer/guides/how-to-use-oauth2/)
  or by making a Basic Auth API request to
  [this](https://mailchimp.com/developer/reference/authorized-apps/) endpoint
  1. Store your username and the token from your request in your local
  credential manager so that it may be retrieved in your
  `mailchimp_secretless.yml`
  1. Run Secretless locally
     ```
       ./dist/darwin/amd64/secretless-broker \
       -f examples/generic_connector_configs/mailchimp_secretless.yml
     ```
  1. On another terminal window, make a request to Mailchimp using Secretless
    ```
      http_proxy=localhost:8011 curl -X GET {dc}.api.mailchimp.com/3.0/
    ```

</details>

___

### OAuth 2.0 API
This generic OAuth HTTP connector can be used for any service that accepts a
Bearer token as an authorization header.

The configuration file for the OAuth 2.0 API can be found at
[oauth2_secretless.yml](./oauth2_secretless.yml).

#### How to use this connector
* Edit the supplied service configuration to get your OAuth token

* Run Secretless with the supplied configuration(s)

* Query the API using
  ```
  http_proxy=localhost:8071 curl {Your OAuth2 API Endpoint URL}/{Request}
  ```

___

### SendGrid Web API
This example can be used to interact with the
[SendGrid Web API](https://sendgrid.com/docs/API_Reference/api_v3.html).

The configuration file for the SendGrid Web API can be found at
[sendgrid_secretless.yml](./sendgrid_secretless.yml).

> This configuration uses
[v3](https://sendgrid.com/docs/API_Reference/api_v3.html) of the SendGrid Web
API.

#### How to use this connector

* Edit the supplied configuration to get your
[SendGrid API Key](https://app.sendgrid.com/settings/api_keys)

* Run Secretless with the supplied configuration(s)

* Query the API using
  ```
  http_proxy=localhost:8071 curl api.sendgrid.com/{Request}
  ```

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Generate a
     [SendGrid API Key](https://sendgrid.api-docs.io/v3.0/how-to-use-the-sendgrid-v3-api/api-authentication)
  1. Store the token from your request in your local credential manager so
    that it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
     ./dist/darwin/amd64/secretless-broker \
     -f examples/generic_connector_configs/sendgrid_secretless.yml
     ```
  1. On another terminal window, make a request to SendGrid using Secretless
     ```
       http_proxy=localhost:8071 curl --request POST \
       --url api.sendgrid.com/v3/mail/send \
       --header "Authorization: Bearer $SENDGRID_API_KEY" \
       --header 'Content-Type: application/json' \
       --data '{"personalizations": [{"to": [{"email": "test@example.com"}]}],
       "from": {"email": "test@example.com"},"subject": "Sending with SendGrid
       is Fun","content": [{"type": "text/plain", "value": "and easy to do
       anywhere, even with cURL"}]}'
     ```

</details>

___

### Slack Web API
This example can be used to interact with
[Slack's Web API](https://api.slack.com/apis).

The configuration file for the Slack Web API can be found at
[slack_secretless.yml](./slack_secretless.yml).

> This configuration was created on June 22, 2020. You can read about
what changes have been made in the
[Slack changelog](https://api.slack.com/changelog)

#### How to use this connector

* Edit the supplied configuration to get your Slack
  [OAuth token](https://api.slack.com/legacy/oauth#flow)

* Run Secretless with the supplied configuration(s)

* Query the Slack API
  ```
  http_proxy=localhost:9030 curl -d {data} {Slack Endpoint URL}
  ```
  ```
  http_proxy=localhost:9040 curl -d {data} {Slack Endpoint URL}
  ```
  Your query depends on if your endpoint requires JSON or URL encoded requests.

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Get the Slack
  [application's tokens](https://slack.com/help/articles/215770388-Create-and-regenerate-API-tokens)
  1. Store the token from your request in your local credential manager so that
  it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
       ./dist/darwin/amd64/secretless-broker \
       -f examples/generic_connector_configs/slack_secretless.yml
     ```
  1. On another terminal window, make a request to Slack using Secretless
     ```
       http_proxy=localhost:9030 curl -X POST --data '{"channel":"C061EG9SL",
       "text":"I hope the tour went well"}' slack.com/api/chat.postMessage
     ```

</details>

___

### Splunk API
This example can be used to interact with
[Splunk's API](https://api.slack.com/apis).

The configuration file for the Splunk Web API can be found at
[splunk_secretless.yml](./splunk_secretless.yml).

> This configuration uses v8.0.5 of the SendGrid Web API.

#### How to use this connector

* Edit the supplied configuration to get your
  [Splunk authentication token](https://docs.splunk.com/Documentation/Splunk/8.0.2/Security/EnableTokenAuth)
  from the correct provider/path
* Create a Splunk
  [certficate](https://docs.splunk.com/Documentation/Splunk/8.0.2/Security/Howtoself-signcertificates)
  and add the certificate to
  [Secretless's trusted certificate pool](https://docs.secretless.io/Latest/en/Content/References/connectors/scl_handlers-https.htm#Manageservercertificates)
* Run Secretless with the supplied configuration
* Query the Splunk API using

  ```
  http_proxy=localhost:8081 curl {instance host name or IP address}:{management port}/{route}
  ```
> Note: You do not preface your instance host name with `https://`.
Secretless will ensure the final connection to the backend server uses SSL.

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Run a local instance of Splunk in a Docker container
     ```
     docker run \
         -d \
         -p 8000:8000 \
         -p 8089:8089 \
         -e "SPLUNK_START_ARGS=--accept-license" \
         -e "SPLUNK_PASSWORD=specialpass" \
         --name splunk \
         splunk/splunk:latest
     ```
  1. Follow the instructions
  [here](https://docs.splunk.com/Documentation/Splunk/8.0.2/Security/EnableTokenAuth)
  to create a local Splunk token using Splunk Web
  1. Store the token from your request in your local credential manager so that
  it may be retrieved in your `secretless.yml`</code>`
  1. Add 'SplunkServerDefaultCert' at IP 127.0.0.1 to etc/hosts on the machine.
  This was so the host name of the HTTP Request would match the name on the
  certificate that is provided on our Splunk container.
  1. Use the provided `cacert.pem` file on the Splunk docker container for
  the certificate, and write it to the local machine
     ```
      docker exec -it splunk sudo cat /opt/splunk/etc/auth/cacert.pem > myLocalSplunkCertificate.pem
     ```
  1. Set a variable in the local environment named
  [SECRETLESS_HTTP_CA_BUNDLE](https://docs.conjur.org/latest/en/Content/References/connectors/scl_handlers-https.htm?TocPath=Fundamentals%7CSecretless%20Pattern%7CService%20Connectors%7CHTTP%7C_____0)
  and set it to the path where `myLocalSpunkCertificate.pem` was on the local
  machine.
  1. Run Secretless
     ```
      ./dist/darwin/amd64/secretless-broker \
      -f examples/generic_connector_configs/splunk_secretless.yml
     ```
  1. On another terminal window, make a request to Splunk using Secretless
     ```
      http_proxy=localhost:8081 curl -k -X GET \
      SplunkServerDefaultCert:8089/services/apps/local
     ```

</details>

___

### Stripe API
This example can be used to interact with
[Stripe's API](https://stripe.com/docs/api).

The configuration file for the Stripe API can be found at
[stripe_secretless.yml](./stripe_secretless.yml).

This example supports several header configurations, so it is recommended to
look at [stripe_secretless.yml](./stripe_secretless.yml) to figure out which
one should be used.

> This configuration uses v2020-03-02. of the SendGrid Web API. A
[`Stripe-Version` header](https://stripe.com/docs/api/versioning)
 can be added to use this version.

#### How to use this connector

* Get the [Stripe API Key](https://dashboard.stripe.com/apikeys),
which can be used as a Bearer token
* Get a [connected account](https://stripe.com/docs/connect/authentication)
or generate an
[idempotency key](https://stripe.com/docs/api/idempotent_requests) if needed
* Query the Striple API using
`http_proxy=localhost:80*1 curl api.stripe.com/{route}`.

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Get the Stripe test [API Key](https://dashboard.stripe.com/apikeys)
  1. Store the token from your request in your local credential manager so that
  it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
       ./dist/darwin/amd64/secretless-broker \
       -f examples/generic_connector_configs/stripe_secretless.yml
     ```
  1. On another terminal window, make a request to Stripe using Secretless
     ```
      http_proxy=localhost:{secretless-server} curl api.stripe.com/v1/charges
     ```

</details>

___

### Tableau API
This example can be used to interact with
[Tableau's API](https://help.tableau.com/current/api/rest_api/en-us/REST/rest_api.htm).

The configuraton file for the Tableau API can be found at
[tableau_secretless.yml](./tableau_secretless.yml).

> This configuration uses v3.6 of the Tableau API.

#### How to use this connector
* Create an account for Tableau Online
* Make a request to Tableu's API to get an
[`X-Tableau-Auth`](https://help.tableau.com/current/api/rest_api/en-us/REST/rest_api_concepts_auth.htm)
token.
* Run Secretless with the supplied configuration(s)
* Query the API using localhost:8071 curl {data} {Tableau Endpoint URl}

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Create an account on
  [Tableau Online](https://www.tableau.com/products/cloud-bi#form)
  1. [Make a Post Request](https://help.tableau.com/current/api/rest_api/en-us/REST/rest_api_get_started_tutorial_part_1.htm#step-1-sign-in-to-your-server-with-rest)
  to Tableau Online's API using the provided credentials to secure a
  `X-Tableau-Auth`
  1. Store the token from your request in your local credential manager so that
  it may be retrieved in your `secretless.yml`
  1. On another terminal window, make a request to Tableau using Secretless
     ```
      http_proxy=localhost:8071 curl -d {data} {Tableau Endpoint URL}
     ```

</details>

___

### Twitter API
This example can be used to interact with
[Twitter's API](https://developer.twitter.com/en/docs).

The configuration file for the Twitter API can be found at
[twitter_secretless.yml](./twitter_secretless.yml).

**Note:** This configuration currently only supports connecting to the
Twitter API via OAuth2. An issue can be found
[here](https://github.com/cyberark/secretless-broker/issues/1297)
for adding an OAuth1 Connector for Twitter.

> This configuration uses
[v7](https://developer.twitter.com/en/docs/ads/general/overview/versions) of
the Twitter API.

#### How to use this connector

* Edit the supplied service configuration to get your
[OAuth token](https://developer.twitter.com/en/docs/basics/authentication/oauth-2-0/bearer-tokens)
* Run Secretless with the supplied configuration(s)
* Query the API using `http_proxy=localhost:8051 curl api.twitter.com/{Request}`

#### Example Usage
<details>
  <summary><b>Example setup to try this out locally...</b></summary>

  1. Get your
  [Twitter API key and Secret Key](https://developer.twitter.com/en/apps)
  1. Get an
  [OAuth token](https://developer.twitter.com/en/docs/basics/authentication/oauth-2-0/bearer-tokens)
  from Twitter through cURL
     ```
      curl -u 'API key:API secret key' \
      --data 'grant_type=client_credentials' \
      'https://api.twitter.com/oauth2/token'
     ```
  1. Store the token from your request in your local credential manager so that
  it may be retrieved in your `secretless.yml`
  1. Run Secretless locally
     ```
      ./dist/darwin/amd64/secretless-broker \
      -f examples/generic_connector_configs/twitter_secretless.yml
     ```
  1. On another terminal window, make a request to Twitter using Secretless
     ```
      http_proxy=localhost:8051 \
      curl "api.twitter.com/1.1/followers/ids.json?screen_name=twitterdev"
     ```

</details>

## Contributing

Do you have an HTTP service that you use? Can you write a Secretless generic
connector config for it? **Add the sample config to this folder and list it in
the table above!** Others may find your connector config useful, too - [send us
a PR](https://github.com/cyberark/community/blob/master/CONTRIBUTING.md#contribution-workflow)!
