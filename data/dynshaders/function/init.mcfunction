scoreboard objectives add disable-effects trigger
scoreboard objectives add enable-effects trigger

{% for k, v in v.uniforms.items() %}
scoreboard objectives add {{ v.name | default(v) }} dummy {{ k }}
{% endfor %}
