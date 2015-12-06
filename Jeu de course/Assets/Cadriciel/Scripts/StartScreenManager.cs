using UnityEngine;
using System.Collections;

public class StartScreenManager : MonoBehaviour
{
    public Texture StartButtonTexture;
    public Texture ExitButtonTexture;
    [SerializeField]
    Vector2 StartButtonPosition;
    [SerializeField]
    Vector2 StartButtonSize;
    [SerializeField]
    Vector2 ExitButtonPosition;
    [SerializeField]
    Vector2 ExitButtonSize;

    void Awake()
    {
        Input.simulateMouseWithTouches = true;
    }

    // Update is called once per frame
    void Update()
    {
    }
    void OnGUI()
    {
        Vector2 screenCenter = new Vector2(Screen.width / 2, Screen.height / 2);
		if (GUI.Button(new Rect(screenCenter.x + StartButtonPosition.x, screenCenter.y + StartButtonPosition.y, StartButtonSize.x, StartButtonSize.y), StartButtonTexture))
        {
            Application.LoadLevel("course");
        }

		if (GUI.Button(new Rect(screenCenter.x + ExitButtonPosition.x, screenCenter.y + ExitButtonPosition.y, ExitButtonSize.x, ExitButtonSize.y), ExitButtonTexture))
        {
            Debug.Log("QUIT");
            Application.Quit();
        }

    }
}
