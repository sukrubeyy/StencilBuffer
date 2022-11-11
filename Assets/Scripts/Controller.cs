using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Controller : MonoBehaviour
{
    public GameObject[] bufferObjects;
    public GameObject[] writeObjects;
    public Color[] colors;

    private void Start()
    {
        for (int i = 0; i < bufferObjects.Length; i++)
        {
            bufferObjects[i].GetComponent<Renderer>().material.SetInt("_StencilRef", i + 1);
            bufferObjects[i].GetComponent<Renderer>().material.SetColor("_Maincolor", colors[i]);
            writeObjects[i].GetComponent<Renderer>().material.SetInt("_StencilRef", i + 1);
        }
    }
}
