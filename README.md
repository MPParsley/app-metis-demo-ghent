# app-metis-demo-ghent

Metis implementation for the City of Ghent, reuses most of the centrale vindplaats frontend.

To test locally you can use the following query to get relevant URIs:
```sparql
select distinct ?Concept where {?Concept a <http://data.vlaanderen.be/ns/toestemming#VerwerkingsActiviteit>} LIMIT 100
```

Then replace https://qa.stad.gent with http://localhost to get a uri like http://localhost/id/data-processing/activities/06d21c71-2ca7-e911-80e6-005056935251

## Local development

```sh
docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d
cd frontend-metis-ghent
npm run start -- -proxy http://localhost
```

## Troubleshooting

- EMFILE: too many open files, watch - `brew install watchman`
