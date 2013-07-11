#!/usr/bin/env ruby
#
# CodebaseHQ API
#
# Get list of users
#
# Marcus Vinicius Fereira            ferreira.mv[ at ].gmail.com
# 2013-07
#

@username = ENV['GITHUB_USER']
@password = ENV['GITHUB_PASS']
@org      = ENV['GITHUB_ORG']

# puts "# username: #{@username}"
# puts "# apikey:   #{@apikey}"
# puts "# domain:   #{@domain}"

require 'uri'
require 'net/http'
require 'net/https'
require 'json'


def github_api_get(url)

  url = URI.parse("https://api.github.com/#{url}")

  # using https
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  # Ref:
  #     Authentication
  #     http://developer.github.com/v3/#authentication
  #
  req = Net::HTTP::Get.new(url.path)
  req.basic_auth("#{@username}", "#{@password}" )

  # response is a JSON string
  response = http.start { |http| http.request(req) }.body

  return JSON.parse(response)

end


# All repositories from an Organization
# Ref:
#     http://developer.github.com/v3/orgs/
#

repos = github_api_get("orgs/#{@org}/repos")

repos.each do |repo|

  printf "%-35s # %s \n", repo['full_name'], repo['description']

end


# vim:ft=ruby:

