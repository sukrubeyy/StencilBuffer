Shader "Unlit/StencialWrite"
{
    Properties
    {
    [IntRange] _StencilRef ("Stencil Reference Value", Range(0,255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry-1"}
        LOD 100
        Stencil{
			Ref [_StencilRef]
			Comp Always
			Pass Replace
		        }
        Pass
        {
            //Bu, gölgelendirici tarafından döndürülen rengin tamamen yok sayılacağı ve 
            //daha önce oluşturulan rengin tamamen korunacağı anlamına gelir.
            Blend Zero One
            ZWrite Off

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
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                return 0;
            }
            ENDCG
        }
    }
}
