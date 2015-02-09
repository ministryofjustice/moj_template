# Ministry of Justice Template


This repository is intended to provide a consistent starting point for Ministry of Justice services that are hosted on the gov.uk domain. It includes a basic shared layout and assets that are used across multiple projects.

------

[View Changelog](https://github.com/ministryofjustice/moj_template/blob/master/CHANGELOG.md)

## Requirements

The Ruby language (1.9.3+), the build tool [Rake](http://rake.rubyforge.org/) & the dependancy management tool [Bundler](http://bundler.io/)

## Packaging

At present this generates 5 output formats:

1. [a gem containing a Rails engine](#gem-version)
2. [a tarball containing Play Framework templates](#play-version)
3. [a folder containing Mustache templates](#mustache-version)
4. [a tarball containing Mustache Inheritance templates](#mustache-inheritance-version)
5. [a tarball](#tarball-version)
6. [a django python package](#django-version)
6. [a Jinja python package](#jinja-version)

### Gem version

The gem is available on [rubygems.org](https://rubygems.org/gems/moj_template). To use it, add this line to your application's Gemfile (change the tag to the version you would like to use):

    gem 'moj_template', '0.23.0'

And then execute:

    bundle

You can then use the `moj_template` layout in your app.  If you need to extend the layout you can use [nested layouts](http://guides.rubyonrails.org/layouts_and_rendering.html#using-nested-layouts).

**Note: After making changes to sass files within the template run `rake tmp:clear` in your rails app to clear any existing cached files.**

#### Gem Config

In order for these files to work, you will need to set a number of variables in your application.rb for things like project title, current phase, etc. If you are encountering errors when trying to use the toolkit, make sure the following are set inside your class Application (example values from a current project provided):

    # Application Title (Populates <title>)
    config.app_title = ''
    # Proposition Title (Populates proposition header)
    config.proposition_title = ''
    # Current Phase (Sets the current phase and the colour of phase tags)
    # Presumed values: alpha, beta, live
    config.phase = ''
    # Product Type (Adds class to body based on service type)
    # Presumed values: information, service
    config.product_type = ''
    # Feedback URL (URL for feedback link in phase banner)
    config.feedback_url = ''
    # Google Analytics ID (Tracking ID for the service)
    config.ga_id = ''

### Django version

The Django package is available on [pypi.python.org](https://pypi.python.org/pypi/django-moj-template). To use the django package, add the following package to `requirements.txt`:

    django-moj-template==0.1.0

Then run:

    pip install -r requirements.txt

Add `moj_template` to your `INSTALLED_APPS` in your `settings.py` file. Eg:

  INSTALLED_APPS = (
    ...
    'moj_template',
    ...
  )

Then to use the template in your application extend your base template from the `moj_template` using:

    {% extends 'moj_template/base.html' %}

#### Django Config

You will be required to set up some additional config to use the package.

Create a new file called `{app_path}/context_processors.py` with the following contents:

    def globals(request):
      return {
        'app_title': '', # Application Title (Populates <title>)
        'proposition_title': '', # Proposition Title (Populates proposition header)
        'phase': '', # Current Phase (Sets the current phase and the colour of phase tags). Presumed values: alpha, beta, live
        'product_type': '', # Product Type (Adds class to body based on service type). Presumed values: information, service
        'feedback_url': '', # Feedback URL (URL for feedback link in phase banner)
        'ga_id': '' # Google Analytics ID (Tracking ID for the service)
      }

Then add the following to your `TEMPLATE_CONTEXT_PROCESSORS` in `settings.py`:

    "{app_path}.context_processors.globals"

### Jinja version

Similarly to Django instructions include the package in `requirements.txt`:

    jinja-moj-template==0.17.0

Add `moj_template` to your `INSTALLED_APPS` in `settings.py` file:

    INSTALLED_APPS = (
      ...
      'moj_template',
      ...
    )
Extend from Jinja base template:

    {% extends 'moj_template/base.jinja' %}


### Play version

To generate the tarball of Play Framework templates run `bundle exec rake build:play`. This will produce a tarball in the `pkg` directory.

### Mustache version

To generate the folder of Mustache templates run `bundle exec rake build:mustache`. This will produce a folder in the `pkg` directory.

### Mustache Inheritance version

There is a [proposal for Mustache to support template inheritance](https://github.com/mustache/spec/issues/38) this is supported in both the `mustache.java` and the `hogan.js` implementations of Mustache.

To generate the tarball of the Mustache Inheritance templates run the `build:mustache_inheritance` rake task. This will produce a tarball in the `pkg` directory.

### Liquid version

To generate the folder of Liquid templates run `bundle exec rake build:liquid`. This will produce a tarball in the `pkg` directory.

### Tarball version

To generate the tarball, run the `bundle exec rake build:tar` rake task. This will produce a tarball in the `pkg` directory.

## Publishing

After an accepted contribution (pull request merged into master), checkout master, increase the version in `lib/moj_template/version.rb` using [Semantic Versioning](http://semver.org/), update `CHANGELOG.md` with the changes made on that version and push back to the remote. **DO NOT tag the repository manually**.

This will trigger a jenkins build and on success it will publish the following packages and tag the remote repository with the new version number:

* [A gem on RubyGems.org](https://rubygems.org/gems/moj_template)
* [A Django python package](https://pypi.python.org/pypi/django-moj-template)

## Development

The source files are in the `/source` directory.  The `compile` rake task builds the `/app` contents from these sources.  This process involves the following:

* compiling all stylesheets referenced in `/manifests.yml` to plain CSS (actually css.erb, so the Rails asset pipeline can work in the gem).
* combining all JavaScript files referenced in `/manifests.yml` (using Sprockets)
* copying the images across (including any needed images from the toolkit)

This resulting app directory is included in the gem and hooked in as a Rails engine

## JS

The JS is written using a slightly adapted [Heisenberg.js](https://github.com/Heisenbergjs/heisenberg) methodology. A main MOJ namespace is created in moj.js and modules are created in separate files and added to this namespace on a project per project basis.

To make use of any modules from the `modules/` folder, include the required module file **after** the `moj.js` file. Here's an example usage:

    //= require modules/moj.tabs.js

