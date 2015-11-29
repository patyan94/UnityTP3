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
        float x = Screen.width / 2 - StartButtonSize.x / 2;
        float y = Screen.height / 2 - StartButtonSize.y / 2;
        if (GUI.Button(new Rect(x, y, StartButtonSize.x, StartButtonSize.y), "Start"))
        {
            Application.LoadLevel("course");
        }

        x = Screen.width / 2 - StartButtonSize.x / 2;
        y = Screen.height / 2 - StartButtonSize.y / 2 + StartButtonSize.y + StartButtonSize.y * 0.1f;
        if (GUI.Button(new Rect(x, y, ExitButtonSize.x, ExitButtonSize.y), "Exit"))
        {
            Debug.Log("QUIT");
            Application.Quit();
        }

    }
}
