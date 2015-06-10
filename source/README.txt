Django version
--------------

To use the django package, add it to your app using:

    pip install moj_template

Then extend your base template from the moj_template using:

    {% extends 'moj_template/base.html' %}

Config
------

You will be required to set up some additional config to use the package. Add the following to your `TEMPLATE_CONTEXT_PROCESSORS`:

    "{app_path}.apps.core.context_processors.globals"

Then include the following in a new file called `apps/core/context_processors.py`:

    def globals(request):
      return {
        'app_title': '', # Application Title (Populates <title>)
        'proposition_title': '', # Proposition Title (Populates proposition header)
        'phase': '', # Current Phase (Sets the current phase and the colour of phase tags). Presumed values: alpha, beta, live
        'product_type': '', # Product Type (Adds class to body based on service type). Presumed values: information, service
        'feedback_url': '', # Feedback URL (URL for feedback link in phase banner)
      }
