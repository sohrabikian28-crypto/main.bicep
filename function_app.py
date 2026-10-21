import azure.functions as func
import logging

app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)

@app.route(route="http_trigger")
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    lastname = req.params.get('lastname')
    if not lastname:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            lastname = req_body.get('lastname')

    if lastname:
        logging.info(f"Received lastname: {lastname}")
        return func.HttpResponse(f"Hello, {lastname}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a lastname in the query string or in the request body for a personalized response.",
             status_code=200
        )