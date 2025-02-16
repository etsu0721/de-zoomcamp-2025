import dlt
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import PageNumberPaginator


def paginated_getter():
    client = RESTClient(
        base_url="https://us-central1-dlthub-analytics.cloudfunctions.net",
        # Define pagination strategy - page-based pagination
        # Pages are numbered (1, 2, 3, ...)
        # Start from page 1
        # No total count of pages provided by API, pagination should stop when a page contains no result items
        paginator=PageNumberPaginator(
            base_page=1,   
            total_path=None
        )
    )

    # For page at API endpoint for retrieving taxi ride data
    for page in client.paginate("data_engineering_zoomcamp_api"):
        yield page   # manage memory by yielding data

for page_data in paginated_getter():
    print(page_data)