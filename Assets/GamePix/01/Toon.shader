Shader "Custom/Toon"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    { 
        Pass
       {
       CGPROGRAM
       #pragma vertex vert
       #pragma fragment frag
       #include "UnityCG.cginc"

      
       
       //CPU 2 GPU 的Data
       struct appdata
       {    
           float4 vertex : POSITION;
           float2 uv : TEXCOORD0;
       };

       //vertex 2 fragment 的Data
       struct v2f
       {
           float4 vertex : SV_POSITION;
           float2 uv : TEXCOORD0;  
       };

       
       v2f vert(appdata v)
       {
           v2f o;
           o.vertex = UnityObjectToClipPos(v.vertex);
           o.uv = v.uv;
           return o;
       }
       
       sampler2D _MainTex;

       float4 frag(v2f IN) : SV_Target
       {
           float4 color = tex2D(_MainTex,IN.uv);
           color.r = 0;

           return color;
       }
       ENDCG
        }
    }
}

    

