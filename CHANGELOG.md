# Changelog

A list of basic changes associated with each version. Versions are updated using the [Semantic Versioning](http://semver.org/) system.

#### v0.17.1 (2014-10-16)
  * Hotfix to run either flavour of Python template

#### v0.17.0 (2014-10-10)
  * Introduce Jinja base template

#### v0.16.1 (2014-09-11)
  * Remove 'the' from 'Built by' statement

#### v0.16.0 (2014-08-22)
  * Removed phase banner markup and styles **Warning:** You will now need to move the phase banner directly into your app
  * Updated govuk template dependencies to v0.8.1

#### v0.15.0 (2014-07-30)
  * Header bar message is now fully customisable

#### v0.14.3 (2014-07-17)
  * Fix js-enabled removal to not target all other browsers

#### v0.14.2 (2014-07-14)
  * Correct 'Working at' URL in console message

#### v0.14.1 (2014-07-11)
  * Fix removing js-enabled for IE6 (not greater than 6)

#### v0.14.0 (2014-07-09)
  * Add yeild for header links

#### v0.13.0 (2014-06-30)
  * Disable 'js-enabled' class for IE6

#### v0.12.0 (2014-05-13)
  * Allow support links to be overridden

#### v0.11.1 (2014-04-01)
  * Add IE Stylesheets in conditional comments

#### v0.11.0 (2014-04-01)
  * Remove Google Analytics from head. Add tracking manually at app level from now.

#### v0.10.3 (2014-03-21)
  * Fix error in prop header

#### v0.10.2 (2014-03-18)
  * Fix issue with other language compilers

#### v0.10.1 (2014-03-18)
  * Add phase indicator gutter fix
  * Fix service name header gutter widths

#### v0.10.0 (2014-03-11)
  * IP addresses in Google Analytics are now anonymized

#### v0.9.1 (2014-03-07)
  * Debug Travis github hook

#### v0.9.0 (2014-03-07)
  * Use Jenkins instead of Travis as CI
  * Auto release to Rubygems and PyPi on successful builds of master

#### v0.8.0 (2014-03-06)
  * Add automated tests using Travis CI

#### v0.7.0 (2014-03-05)
  * Update MOJ Blog URL

#### v0.6.1 (2014-03-05)
  * Fix broken changelog link in readme

#### v0.6.0 (2014-03-05)
  * Add initial set of tests for mustache version

#### v0.5.9 (2014-03-04)
  * Remove Gemfile.lock from repo to reduce conflicts

#### v0.5.8 (2014-03-03)
  * Update readme instructions

#### v0.5.7 (2014-03-03)
  * Remove the `app` folder from repository. No longer needed as gem is on rubygems.org

#### v0.5.6 (2014-02-26)
  * Remove GOV.UK mainsteam footer links
  * Correct built by to MOJ

#### v0.5.5 (2014-02-21)
  * Correct publish rake command

#### v0.5.4 (2014-02-21)
  * Updated govuk_template/frontend_toolkit

#### v0.5.3 (2014-02-21)
  * Change path for version checking on python package publishing

#### v0.5.2 (2014-02-21)
  * Fix auto publish for django template

#### v0.5.1 (2014-02-20)
  * Correct URL for Python package file

#### v0.5.0 (2014-02-20)
  * Add Django Package version

#### v0.4.3 (2014-02-18)
  * Add ability to auto publish gem to Rubygems using rake task

#### v0.4.2 (2014-02-18)
  * Add clearfix sass helper

#### v0.4.1 (2014-02-17)
  * Capitalize service phase in service header

#### v0.4.0 (2014-02-14)
  * Add basic styles for .inner

#### v0.3.0 (2014-02-14)
  * Add yield for custom analytics

#### v0.2.0 (2014-02-14)
  * Remove alpha-beta shame css

#### v0.1.0 (2014-02-14)
  * First minor release
  * Includes:
    * Rails gem
    * Multiple other formats including mustache, play and liquid
