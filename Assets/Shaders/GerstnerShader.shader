// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/GerstnerShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0

		//_Amplitude ("Amplitude", Float) = 1
		//_Steepness ("Steepness", Range(0, 1)) = 0.5
		//_Wavelength ("Wavelength", Float) = 10
		//_Direction ("Direction (2D)", Vector) = (1, 0, 0, 0)
		//_Speed ("Speed", Float) = 1
		_WaveA ("Wave A (dir, steepness, wavelength", Vector) = (1, 0, 0.5, 10)
		_WaveB ("Wave B", Vector) = (0, 1, 0.25, 20)
		_WaveC ("Wave C", Vector) = (1, 1, 0.15, 10)
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard vertex:vert addshadow alpha fragment:frag //fullforwardshadows
		
        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0
		#include "UnityCG.cginc" //

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

		struct v2f {
			half3 worldRefl : TEXCOORD0;
			float4 pos : SV_POSITION;
		};//

        half _Glossiness;
        half _Metallic;
        fixed4 _Color;

		//float _Steepness, _Wavelength; _Speed;
		//float2 _Direction;
		float4 _WaveA, _WaveB, _WaveC;

		float sqrtWave(float wavelength2) {
			return sqrt(9.8 / wavelength2);
		}

		float fluidPosition(float steepness, float wavelength2) {
			return steepness / wavelength2;
		}

		float3 MakeTangent(float2 normaliseWave, float steepness, float f) {
			return float3(
				-normaliseWave.x * normaliseWave.x * (steepness * sin(f)),
				normaliseWave.x * (steepness * cos(f)),
				-normaliseWave.x * normaliseWave.y * (steepness * sin(f))
				);
		}

		float3 MakeBinormal(float2 normaliseWave, float steepness, float f) {
			return float3(
				-normaliseWave.x * normaliseWave.y * (steepness * sin(f)),
				normaliseWave.y * (steepness * cos(f)),
				-normaliseWave.y * normaliseWave.y * (steepness * sin(f))
				);
		}
		
		float3 MakeWave(
			float4 wave, float3 p, inout float3 tangent, inout float3 binormal
		) {
			float steepness = wave.z;
			float wavelength = wave.w;
			float wavelength2 = 2 * UNITY_PI / wavelength;
			float phaseSpeed = sqrtWave(wavelength2);
			float2 normaliseWave = normalize(wave.xy);
			float f = wavelength2 * (dot(normaliseWave, p.xz) - phaseSpeed * _Time.y);
			float fluidPos = fluidPosition(steepness, wavelength2);

			tangent += MakeTangent(normaliseWave, steepness, f);
			
			binormal += MakeBinormal(normaliseWave, steepness, f);
			
			return float3(
				normaliseWave.x * (fluidPos * cos(f)),
				fluidPos * sin(f),
				normaliseWave.y * (fluidPos * cos(f))
				);

		}
		
		void vert(inout appdata_full vertexData) {
			float3 gridPoint = vertexData.vertex.xyz;
			float3 tangent = float3(1, 0, 0);
			float3 binormal = float3(0, 0, 1);
			float3 wave = gridPoint;

			wave += MakeWave(_WaveA, gridPoint, tangent, binormal);
			wave += MakeWave(_WaveB, gridPoint, tangent, binormal);
			wave += MakeWave(_WaveC, gridPoint, tangent, binormal);
			
			float3 normal = normalize(cross(binormal, tangent));
			
			vertexData.vertex.xyz = wave;
			vertexData.normal = normal;
		}

		v2f vert(float4 vertex : POSITION, float3 normal : NORMAL) {
			v2f o;
			o.pos = UnityObjectToClipPos(vertex);
			float3 worldPos = mul(unity_ObjectToWorld, vertex).xyz;
			float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
			float3 worldNormal = UnityObjectToWorldNormal(normal);
			o.worldRefl = reflect(-worldViewDir, worldNormal);

			return o;
		}

		fixed4 frag(v2f i) : SV_TARGET{
			half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, i.worldRefl);
			half3 skyColour = DecodeHDR(skyData, unity_SpecCube0_HDR);
			fixed4 c = 0;
			c.rgb = skyColour;

			return c;
		}

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    //FallBack "Diffuse"
}
