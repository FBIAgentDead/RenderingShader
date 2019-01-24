using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Movement : MonoBehaviour {
	Rigidbody rigidbody2;

	void Start()
	{
		rigidbody2 = GetComponent<Rigidbody>();
	}
	void Update () {
		if (Input.GetKey(KeyCode.LeftArrow))
		{
			rigidbody2.AddForce(Vector3.left, ForceMode.Impulse);
		}
        if (Input.GetKey(KeyCode.RightArrow))
        {
            rigidbody2.AddForce(-Vector3.left, ForceMode.Impulse);
        }
        if (Input.GetKey(KeyCode.UpArrow))
        {
            rigidbody2.AddForce(Vector3.forward, ForceMode.Impulse);
        }
        if (Input.GetKey(KeyCode.DownArrow))
        {
            rigidbody2.AddForce(-Vector3.forward, ForceMode.Impulse);
        }
    }
}
