import { Toast as ToastBootstrap} from "react-bootstrap";

interface IToast {
    show: boolean;
    message: string;
    colors?: string;
    onClose: () => void;
}

export const Toast = (props: IToast) =>{
    return(
        <ToastBootstrap
            onClose={props.onClose}
            show={props.show}
            delay={3000}
            bg={props?.colors ? props.colors : 'success'}
            autohide
            style={{
                position: 'absolute',
                zIndex: 99,
                right: 0
            }}
        >
            <ToastBootstrap.Body
            style={{
                color: 'fff'
            }}
            >
                {props.message}
            </ToastBootstrap.Body>
        </ToastBootstrap>
    )
}