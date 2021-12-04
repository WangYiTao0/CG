Shader "Unity6000/SurDiffuse"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _Center ("Center", Vector) = (0,0,0,0)
        _Radius ("Radius", Float) = 0.5

    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200
        

        CGPROGRAM
        #include "UnityPBSLighting.cginc"
        #pragma surface surf Lambert
        
        struct Input
        {
            float3 worldPos;
            half2 uv_MainTex: TEXCOORD0;
            float3 color : Color;
        };

        sampler2D _MainTex;
        fixed4 _Color;
        float3 _Center;
        float _Radius;
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            //中心点的位置距离sssss
            float d = distance(_Center, IN.worldPos);
            // d / radius  距离 含半径的比值
            float dN = 1 - saturate(d/_Radius);
            // 0.75 到 0.7 之间的位置 
            if(dN>0.25 && dN < 0.26)
            {
                o.Albedo = half3(1,1,1);   
            }
            else
            {
                o.Albedo =  tex2D(_MainTex,IN.uv_MainTex) * _Color;
            }
        }
        ENDCG
    }
    // 当上面所有SubShader 功能都不支持的时候 会执行FallBack
    // 简单的光照计算
    //FallBack "Diffuse"
}
