# {{ item }}
$scoreboard players set @s {{ v.uniforms[item].name | default(v.uniforms[item]) }} $(val)
