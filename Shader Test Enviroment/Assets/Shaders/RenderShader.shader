Shader "MyShaders/RenderShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_CharacterPosition("char pos", vector) = (0,0,0,0)
		_CircleRadius("SpotlightRadius", Range(0,20)) = 3
		_RingSize("Ring size", Range(0,5)) = 1
		_ColorTint("Outside Border", Color) = (0,0,0,0)
		_TransParent("Transparent", Color) = (0,0,0,1)
		_PulseFloat("The sound pulse", float) = 0
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
			
			float4 _CharacterPosition;
			float _CircleRadius;
			float _RingSize;
			float4 _ColorTint;
			float4 _TransParent;
			float _PulseFloat;
			
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
				// sample the texture
				fixed4 col = (0,0,0,0);

				float dist = distance(i.worldPos, _CharacterPosition.xyz);

				if(dist < _CircleRadius){
					col = _TransParent;
				}
				else if(dist > _CircleRadius && dist < _CircleRadius + _RingSize){
					float blendStrenght = dist - _CircleRadius;
					col = lerp(_TransParent, _ColorTint, 0.5);
				}else{
					clip(-1);
				}
				return col;
			}
			ENDCG
		}
	}
}
