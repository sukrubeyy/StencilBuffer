using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraRotate : MonoBehaviour
{
    public float speed;
    void Update()
    {
        transform.Rotate(new Vector3(0, speed * Time.fixedDeltaTime, 0));
    }
}
