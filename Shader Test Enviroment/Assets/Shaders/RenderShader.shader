Shader "MyShaders/RenderShader"
{
	Properties
	{
		_MainTex ("Main Texture but is not used", 2D) = "white" {}
		_ColorTint("The Object color when no vision", Color) = (0,0,0,0)
		_RevealTexture("The Pulse texture that is shown", 2D) = "white"
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float3 worldPos : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			float _SoundWave[100];
			float _RingSize[100];
			float4 _ColorTint;
			sampler2D _RevealTexture;
			float4 _RevealTexture_ST; 
			vector _ObjectPositions[100];
			int _ArrayLenght;
			float _MaxDistance[100];

			float temp;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{

				fixed4 col = _ColorTint;

				for(int j = 0; j < _ArrayLenght; j++){
					float dist = distance(i.worldPos, _ObjectPositions[j].xyz);
					if(dist > _SoundWave[j] && dist < _SoundWave[j] + _RingSize[j]){
						col = tex2D(_RevealTexture, i.uv);
					}
					else if(dist < _SoundWave[j] && dist > _SoundWave[j]-(_RingSize[j]*8) ){
						float t = 1/(_SoundWave[j]/(_RingSize[j]*8)) * (dist - (_SoundWave[j]-(_RingSize[j]*4))); 
						col = lerp(_ColorTint, tex2D(_RevealTexture, i.uv), t);
					}
				}
				return col;
			}
			ENDCG
		}
	}
}
