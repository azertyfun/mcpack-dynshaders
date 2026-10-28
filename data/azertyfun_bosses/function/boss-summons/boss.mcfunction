summon {{ item.summon_type }} {{ item.summon_coords | required | join(' ') }} {{ item.summon_data }}
particle minecraft:explosion {{ item.summon_coords | required | join(' ') }} 1.5 2 1.5 1.0 20
execute positioned {{ item.summon_coords | required | join(' ') }} run execute as @a[distance=..16] run playsound minecraft:block.trial_spawner.ambient_ominous ambient
