{% for boss in v.bosses %}
scoreboard objectives add boss-{{ boss.id }} dummy
{% endfor %}
