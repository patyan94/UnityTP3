using UnityEngine;
using System.Collections;

public class UpdateLookAt : MonoBehaviour {

    public Transform Target;
    [SerializeField]
    private float rotationSpeed;
	// Use this for initialization
	void Awake () {
    }
	
	// Update is called once per frame
	void Update () {
        Vector3 dir = Target.position - transform.position;
        Quaternion rot = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(dir), rotationSpeed * Time.deltaTime);

        transform.rotation = Quaternion.Euler(0, rot.eulerAngles.y, 0);
    }

    public void SetTarget(Transform target)
    {
        Target = target;
    }
}
