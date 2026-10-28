# enable-effects/disable-effects triggers
# =======================================

# enable triggers
scoreboard players enable @a disable-effects
scoreboard players enable @a enable-effects

# reset effects on disable-effects
execute as @a run execute if score @s disable-effects matches 1.. run function dynshaders:reset

# trigger enable-effects -> disable-effects = 0
execute as @a run execute if score @s enable-effects matches 1.. run scoreboard players set @s disable-effects 0
execute as @a run execute if score @s enable-effects matches 1.. run scoreboard players set @s enable-effects 0

# Location-based effects
# ======================

{% for location in v.locations %}
    {% set resolution = location.resolution | default(20) %}
    {% set disable = "unless score @s disable-effects matches 1.." %}

    {% for effect in location.effects %}
        {%- set effectdefault = v.uniforms[effect.name].default | default(0) %}
        # From <radius> to <radius*2>, we reset to 0.
        # Beyond, we don't do anything, so we don't interfere with other potential scripts.
        execute positioned {{ location.coords | required | join(' ') }} run execute as @a[distance=..{{ location.radius * 2 }}] {{ disable }} run function dynshaders:set/{{ effect.name }} {val: {{ effectdefault }}}

        {% for i in range(resolution) %}
            {%- set normval = (effect.strength | default(1.0)) * smoothstep(i / resolution) %}
            {%- set fromval = effectdefault / 100.0 %}
            {%- set toval = (effect.to | default(100)) / 100.0 %}
            {%- set val = mix(fromval, toval, normval) %}
            {%- set roundedval = round(100 * val) -%}
            execute positioned {{ location.coords | required | join(' ') }} run execute as @a[distance=..{{ round((location.min_radius | default(0)) + (location.radius - (location.min_radius | default(0))) * (1.0 - i / resolution)) }}] {{ disable }} run function dynshaders:set/{{ effect.name }} {val: {{ roundedval if roundedval != 99 else 100 }}}
        {% endfor %}
    {% endfor %}
{% endfor %}


# Light triggers
# ==============

{% for t in v.light_triggers %}
    execute positioned {{ t.trigger_coords | required | join(' ') }} run execute as @a[distance=..{{ t.radius | default(1) }}] run \
        scoreboard players set @s {{ v.uniforms.phantom_light_x }} {{ t.light_coords[0] }}
    execute positioned {{ t.trigger_coords | required | join(' ') }} run execute as @a[distance=..{{ t.radius | default(1) }}] run \
        scoreboard players set @s {{ v.uniforms.phantom_light_y }} {{ t.light_coords[1] }}
    execute positioned {{ t.trigger_coords | required | join(' ') }} run execute as @a[distance=..{{ t.radius | default(1) }}] run \
        scoreboard players set @s {{ v.uniforms.phantom_light_z }} {{ t.light_coords[2] }}
    execute positioned {{ t.trigger_coords | required | join(' ') }} run execute as @a[distance=..{{ t.radius | default(1) }}] run \
        scoreboard players set @s {{ v.uniforms.phantom_light_str }} {{ round(t.strength | default(1.2) * 100) }}
{% endfor %}
