{% for k, v in v.uniforms.items() %}
# {{ k }}
scoreboard players set @s {{ v.name | default(v) }} {{ v.default | default(0) }}
{% endfor %}
