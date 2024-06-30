using backend.DTOs;
using FluentValidation;

namespace backend.Validations;

public class UserDtoValidator : AbstractValidator<UserDto>
{
    public UserDtoValidator()
    {
        RuleFor(x => x.EmployeeCode)
            .NotNull().NotEmpty().WithMessage("El codigo de usuario esta vacia o no esta");

        RuleFor(x => x.Name)
            .NotNull().NotEmpty().WithMessage("El nombre del usuario esta vacio o no esta");

        RuleFor(x => x.Lastname)
            .NotNull().NotEmpty().WithMessage("El apellido del usuario esta vacio o no esta");

        RuleFor(x => x.Username)
            .NotNull().NotEmpty().WithMessage("El nombre de usuario del esta vacio o no esta")
            .Matches(@"^[a-zA-Z][a-zA-Z0-9_]{3,20}$").WithMessage("Usuario no es valido! Debe comenzar con una letra, puede contener letras, numeros, y guines bajos (_), debe tener una longitud minima de 3 caracteres y maxima de 20 caracteres.");

        RuleFor(x => x.Password)
            .NotNull().NotEmpty().WithMessage("La contraseña del usuario esta vacia o no esta");

        RuleFor(x => x.Status)
            .NotNull().NotEmpty().WithMessage("El estatus del usuario esta vacio o no esta");

        RuleFor(x => x.Role)
            .NotNull().NotEmpty().WithMessage("El rol del usuario esta vacio o no esta");
    }
}
