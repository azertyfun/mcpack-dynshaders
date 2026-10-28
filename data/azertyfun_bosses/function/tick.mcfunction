{% for boss in v.bosses %}
{% set disable = "unless score @s boss-" + boss.id + " matches 1.." %}
    execute positioned {{ boss.trigger_coords | required | join(' ') }} run \
        execute as @a[distance=..{{ boss.trigger_radius }}] {{ disable }} run \
        schedule function azertyfun_bosses:boss-summons/{{ boss.id }} 5s
    execute positioned {{ boss.trigger_coords | required | join(' ') }} run \
        execute as @a[distance=..{{ boss.trigger_radius }}] {{ disable }} run \
        scoreboard players set @s boss-{{ boss.id }} 1
{% endfor %}
