.PHONY: setup migrate run test shell superuser collectstatic seed

setup:
	pip install -r requirements.txt
	python manage.py migrate
	python manage.py collectstatic --noinput

migrate:
	python manage.py migrate --noinput

run:
	docker compose up --build

test:
	python manage.py test --keepdb

shell:
	python manage.py shell

superuser:
	python manage.py createsuperuser

collectstatic:
	python manage.py collectstatic --noinput

seed:
	python seed.py
