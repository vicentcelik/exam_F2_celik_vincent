using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParticleSpin : MonoBehaviour {
	[SerializeField] private float degreesX = 0F;
	[SerializeField] private float degreesY = 0F;
	[SerializeField] private float degreesZ = 0F;

	private void Start () {
		transform.localRotation = Quaternion.identity;
	}

	private void Update () {
		transform.Rotate (degreesX * Time.deltaTime, degreesY * Time.deltaTime, degreesZ * Time.deltaTime);
	}
}