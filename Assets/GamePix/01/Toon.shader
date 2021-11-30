Shader "Custom/Toon"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Diffuse("Diffuse",Color)=(1,1,1,1)
    }
    SubShader //根据平台选择 SubShader
    { 
        Pass //通道控制GameObject几何体的一次渲染
        {
            Tags
            {
                "LightMode" = "ForwardBase"    
            }
            
            
           CGPROGRAM
           #pragma vertex vert
           #pragma fragment frag
           #include "UnityCG.cginc"
           #include "Lighting.cginc"
           
           //CPU 2 GPU 的Data
           struct appdata
           {    
               float4 vertex : POSITION;
               float2 uv : TEXCOORD0;
               float3 normal : NORMAL;
           };

           //vertex 2 fragment 的Data
           struct v2f
           {
               float4 vertex : SV_POSITION;
               float3 color : Color;
               float2 uv : TEXCOORD0;  
           };

           half4 _Diffuse;
           v2f vert(appdata v)
           {
               v2f o;
               o.vertex = UnityObjectToClipPos(v.vertex);
               fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
               fixed3 worldNormal = normalize(mul(v.normal,(float3x3)unity_WorldToObject));
               fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
               fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal,worldLight));
               o.uv = v.uv;
               o.color = ambient + diffuse;
               return o;
           }
           
           sampler2D _MainTex;

           float4 frag(v2f IN) : SV_Target
           {
               float3 color = tex2D(_MainTex,IN.uv) * IN.color;
               return fixed4(color,1.0);
           }
           ENDCG
        }
    }
}

    

