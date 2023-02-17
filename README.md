# Tropical-Island-Graphics-Scene
Tropical island created using various graphical techniques in Unity.\
Youtube Link: https://youtu.be/gFU4ub8b3wk

## Realistic Ocean Shader
![image](https://user-images.githubusercontent.com/115077902/219665142-61f6d261-ce26-49bc-98d4-0ee7fb3e8eed.png)\
The realistic water plane if first generated in the “WaterGenerator.cs” script which generates the plane mesh of which the water shader can be added too. I then added the “GerstnerShader.shader” which is a fragment and vertex shader which manipulates the vertex’ to give it the wave like look. I also added a fragment shader to allow for reflections, so now the sky should be reflected on the water’s surface.

## Portal Effect
![image](https://user-images.githubusercontent.com/115077902/219665359-e585382b-fbef-46ac-8e6f-fd25308b4fc3.png)\
The portal effect was done by adding a surface shader to a plane. From the “Portal Shader.shader” file I made it so that it would project a 3D cube-map onto the plane so that when the camera flies around it, it almost feels as if you are looking into the portal as you can look at it from different view angles. The effect around the edge of the portal was done by adding a particle system and changing it so that it would run in a circular direction around the portal.

## Weather/Rain Effect
![image](https://user-images.githubusercontent.com/115077902/219665616-63deebda-9e3f-4b77-8987-9c74211edc25.png)\
The weather effect was simply done by adding a particle system as a child object on the camera. This means that the rain effect follows the camera around and gives the effect of rain on the island. It was done by giving the particles a downward force after their generation, with them getting gradually larger the longer they fall which added to the realism effect.

## Rotating Cubes
![image](https://user-images.githubusercontent.com/115077902/219665732-7410028d-7a11-44ff-af0b-86d24d3e663f.png)\
The cubes first are generated through the “CubeGenerator.cs” script that I made which generates 2 cube meshes at the points shown above. The rotating effect of the cubes are done through a C# script as well as a vertex shader. The cubes move up and down in the shape of a Sin wave and this is done by manipulating the vertices in the “CubeMover.shader” file. They then rotate around the Y-axis through the “RotatingCube.cs” file which I made. Through the shader I was also able to add an emissive material to the cubes which makes it look as if they are glowing.

## World Event/Rotating Around Parent
![image](https://user-images.githubusercontent.com/115077902/219665902-7a4ebbc7-f1c7-4e2a-ab83-b22a0c2327db.png)\
For the map changing event I made it so that a large rock emerges from below the ocean which will then be present in this position for the remaining time that the game is run. This rock also has 2 child spheres which are rotating around it. The logic for the rotating spheres can be found in the “RotateAroundParent.cs” script and the logic for the world event can be found in the “WorldEvent.cs” script. Please note that the rock used in this example was not created by me and was an outside asset.

## Campfire Effect
![image](https://user-images.githubusercontent.com/115077902/219666023-24e88641-6fd6-4ad9-b441-b9d6e97bf10d.png)\
The campfire effect was done by adding a particle system as well as a point light to give the effect that the fire is emitting light. The particle effect was done by adding a small fire texture to each particle and each particle was then given an orange/yellow hue. The longer the particles are alive the smaller they get to give the effect of them dissipating.

## Lens Flare
![image](https://user-images.githubusercontent.com/115077902/219666147-fc508edf-d1de-4d85-bc23-6eea71051059.png)\
I have added a subtle lens flare when the camera is looking towards the sun. This was done by adding a lens flare sprite to the directional light that I was using as the sun. Now whenever the camera looks at the sun there is a lens flare present.

## Post-Processing
![image](https://user-images.githubusercontent.com/115077902/219666267-31639aa4-a3b1-4702-a1be-a8eff1cb401c.png)\
To give my emissive textures, the emissive and glowing look I added a bloom post processing effect to the camera so that it could successfully portray the effect to the user.

## Navigable Camera
![image](https://user-images.githubusercontent.com/115077902/219666584-1121834d-f0d5-4aa9-a4ae-fbdc4efe268e.png)\
I also made a navigable camera so that the user can fly around the level. The WASD keys are used for movement, the mouse can be used to look around. The Space key moves the camera upwards on the Y-axis and the LShift key is used to increase the speed to increase the movement speed.

## FPS and Memory Counter
![image](https://user-images.githubusercontent.com/115077902/219666677-6d7f3f12-19e8-4a7b-89e7-233bfdf5183b.png)\
Finally, I added an FPS counter as well as a memory counter to show the performance of my level. FPS was very stable and never really dropped below 100 while memory usage was also very stable around 1000-1500mb when played within Unity’s “Play Mode”. The GC memory shows how much memory on the heap is currently being used by code.

