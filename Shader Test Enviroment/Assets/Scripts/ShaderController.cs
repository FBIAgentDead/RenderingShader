using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShaderController : MonoBehaviour {
	
	public Material shaderStat;
	public Transform character;
	float pulse;
	public float speed;

	void Update()
	{
		shaderStat.SetVector("_CharacterPosition", character.position);
		shaderStat.SetFloat("_PulseFloat", pulse);
		if(Input.GetKey(KeyCode.Space)){
			// the sound pulse behavior
			pulse += Time.deltaTime * speed;
			Debug.Log(pulse);
		}
	}

}
