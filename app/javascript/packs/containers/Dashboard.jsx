import Button from '@material-ui/core/Button';
import { green, red } from '@material-ui/core/colors';
import Snackbar from '@material-ui/core/Snackbar';
import { Formik } from 'formik';
import React, { Component } from 'react';
import { Grid, Paper, SnackbarContent, TextField, Typography, withStyles } from '@material-ui/core';
import LeadForm from '../components/LeadForm';
import Api from '../api';

const SNACKBAR_VARIANTS = {
  success: 'success',
  error: 'error'
};

const serverValidationErrors = (errors) => {
  return errors.reduce((acc, error) => {
    acc[error.params[0]] = error.messages[0];

    return acc;
  }, {});
};

class Dashboard extends Component {
  state = {
    snackbarOpen: false,
    snackbarVariant: null,
    snackbarMessage: ''
  };

  onSubmit = (values, formikBag) => {
    const { setSubmitting, setErrors, resetForm } = formikBag;

    Api.Leads.create(values)
      .then(() => {
        setSubmitting(false);
        this.displaySnackbar(SNACKBAR_VARIANTS.success, 'Thank you for submitting the form.');
        resetForm();
      })
      .catch((error) => {
        setSubmitting(false);
        const { response } = error;

        if (response) {
          if (response.status === 422) {
            setErrors(serverValidationErrors(response.data));
            this.displaySnackbar(SNACKBAR_VARIANTS.error, 'Unable to submit the request. Please, fill the form correctly.');
          }

          if (response.status === 400) {
            this.displaySnackbar(SNACKBAR_VARIANTS.error, 'Unable to submit the request. Unknown error. Please, try again later.');
          }
        }
      });
  };

  displaySnackbar = (variant = SNACKBAR_VARIANTS.success, message = '') => {
    this.setState({
      snackbarOpen: true,
      snackbarVariant: variant,
      snackbarMessage: message
    });
  };

  onSnackbarClose = () => {
    this.setState({
      snackbarOpen: false
    });
  };

  render() {
    const { classes } = this.props;
    const { snackbarOpen, snackbarVariant, snackbarMessage } = this.state;

    return (
      <Grid container justify="center" alignItems="center">
        <Grid item xs={12} sm={9} md={6} lg={4}>
          <Paper className={classes.formWrapper}>
            <Typography variant="h5" gutterBottom>
              Request a callback
            </Typography>

            <Formik
              validateOnChange={false}
              initialValues={{
                email: '',
                name: '',
                business_name: '',
                telephone_number: '',
                contact_time: '',
                notes: '',
                reference: ''
              }}
              onSubmit={this.onSubmit}
              render={props => <LeadForm {...props} />}
            />

            <Snackbar
              anchorOrigin={{
                vertical: 'top',
                horizontal: 'right'
              }}
              open={snackbarOpen}
              autoHideDuration={60000}
              onClose={this.onSnackbarClose}
            >
              <SnackbarContent
                className={classes[SNACKBAR_VARIANTS[snackbarVariant]]}
                message={<span>{snackbarMessage}</span>}
                action={[
                  <Button color="inherit" key="close" size="small" onClick={this.onSnackbarClose}>
                    CLOSE
                  </Button>
                ]}
              />
            </Snackbar>
          </Paper>
        </Grid>
      </Grid>
    );
  }
}

export default withStyles(
  theme => ({
    success: {
      backgroundColor: green[600],
      color: theme.palette.common.white
    },
    error: {
      backgroundColor: red[700],
      color: theme.palette.common.white
    },
    formWrapper: {
      padding: theme.spacing(4)
    }
  })
)(
  Dashboard
);
