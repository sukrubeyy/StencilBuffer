Shader "Unlit/StencilRead"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Maincolor("Main Color",Color)=(1,1,1,1)
        
        [IntRange] _StencilRef ("Stencil Reference Value", Range(0,255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Stencil{
            //Referans Değeri
            Ref [_StencilRef]
            //Stencil İşleminin ne zaman gerçekleşeceğini belirliyor
            Comp Equal
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Maincolor;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return _Maincolor;
            }
            ENDCG
        }
    }
}
